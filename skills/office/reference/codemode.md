# Code mode

One MCP tool, `exec`, whose argument is the body of an async JavaScript function. Inside it, the
upstream servers are reachable, their results are filterable, and only what you return reaches the
model's context.

## Why it is the default here

Nine Craft servers are about 340 tools. Registering them directly puts every schema in context
before any work starts, and a document job then spends its budget on definitions rather than the
document. Code mode inverts that: one call does the discovery, the work, and the reduction.

Use it for the whole task, not for a single call. A round trip per action is the thing it exists
to remove.

## The runtime

| Name | What it is |
|---|---|
| `search(query, { server?, limit? })` | Ranked discovery over tool names, descriptions, servers, and top-level parameter names |
| `describe(name)` | Full input/output schema for one tool |
| `ALL_TOOLS` | Frozen inventory: `{ name, server, tool, title?, description }` |
| `ALL_SERVERS` | `{ server, status, toolCount, error? }` per server |
| `tools.<name>(args)` | Call a tool |
| `call(name, args)` | Same, by string name |
| `text(value)`, `image(dataUrlOrMcpImage, detail?)`, `emit(block)` | Pick output blocks |
| `store(key, value)`, `load(key)`, `clearStore(key?)` | JSON-only state, in memory, for this session |
| `signal` | AbortSignal |

Tool names are normalized to `mcp__<server>__<tool>` — `mcp__deckcraft__add_slide`,
`mcp__pdfcraft__page_render`, `mcp__wordcraft__execute`.

The body runs with top-level `await` and returns its final value. Code executes with the authority
of the MCP server process: filesystem, network, environment, child processes. It is not a sandbox,
so it is not a place to run material you have not read.

## Call patterns

**Discovery before the first call to an app.** Ask, then describe only what you will use:

```js
const hits = search('deck slide insert', { server: 'deckcraft', limit: 6 });
return hits.map(h => ({ name: h.name, description: h.description?.slice(0, 120) }));
```

**Build, then look,** in the order the artifact needs. Sequential awaits when each step depends on
the last id; `Promise.all` only for calls that touch different documents:

```js
await tools.mcp__deckcraft__new_presentation({ theme: 'Paper' });
const cover = await tools.mcp__deckcraft__add_slide({
  layout: 'title', title: 'Q3 review', body: 'Revenue, margin, plan'
});
await tools.mcp__deckcraft__add_slide({
  layout: 'titleAndContent', title: 'Margin',
  body: 'Gross margin up 2.1 points\nServices led the gain'
});
return cover;
```

**Aggregate, do not dump.** Reduce inside the program so the context receives the answer:

```js
const slides = (await tools.mcp__deckcraft__inspect_document({})).structuredContent;
return { count: slides.slides.length, empty: slides.slides.filter(s => s.shapeCount === 0) };
```

**Find a command id you do not know.** Never invent one:

```js
const cmds = await tools.mcp__deckcraft__list_commands({ filter: 'table' });
return cmds;
```

**Verify with an image.** Rendering tools return an MCP image block; pass it through untouched so
it stays an image rather than becoming base64 text:

```js
const shot = await tools.mcp__deckcraft__render_slide({});
const block = (shot.content || []).find(b => b.type === 'image');
return image(block);
```

`image(block)` and `emit(block)` preserve the block. `image('[data:image/png;base64,...]')` works
for a saved PNG you read yourself. Returning a whole `CallToolResult` preserves every field it
carries — text, images, structured content, `isError`, metadata.

**Loop with a concurrency ceiling.** Rendering twenty slides at once will thrash; ten at a time is
a reasonable ceiling:

```js
const idx = Array.from({ length: 20 }, (_, i) => i + 1);
const shots = [];
for (let i = 0; i < idx.length; i += 10) {
  shots.push(...await Promise.all(idx.slice(i, i + 10).map(n =>
    tools.mcp__deckcraft__render_slide({ slide: n })
  )));
}
return shots.map(s => s.content?.[0]?.type);
```

**Persist an id across calls** with `store`, since document and slide ids do not survive a session:

```js
store('deck', { doc: 0, coverId: 260 });
```

**Errors are results.** A failed tool call throws or returns `isError: true` depending on the
server. Wrap a stage, capture the message, and keep going only where the remaining steps do not
depend on the failure:

```js
try {
  await tools.mcp__wordcraft__execute({ command: 'table.insert', params: { rows: 4, cols: 3 } });
} catch (e) {
  return { failed: 'table.insert', message: String(e.message || e) };
}
```

Read the error. `-32602 invalid params` names the offending key, which is faster than guessing.

**Timeouts and output size.** The call accepts `timeout_ms` and `max_output_chars`. A render or an
export can exceed the default; raise `timeout_ms` for those, and filter the result rather than
raising `max_output_chars` and pasting a file into context.

## What not to do

- **Do not call one tool per exec.** Batch the stage.
- **Do not return raw tool results** unless you need them all. A `doc_inspect` on a book can be
  hundreds of kilobytes.
- **Do not use pointer, click or keystroke tools** when a command exists. Commands are
  deterministic and undoable; UI tools depend on window focus and fail silently when the app is
  headless.
- **Do not run two writers on one document.** Parallelism across documents, sequence within one.
- **Do not treat a clean return as a correct artifact.** Render and inspect (see SKILL.md step 4).
- **Do not put credentials in `exec`.** Read them from the environment the server already has.

## Without code mode

If the harness exposes each Craft server directly, the same work is doable — it just costs more
context. Discover with the server's own `list_commands`, call the domain tools directly, and keep
each app's schema out of the way until you need it. The skill's rules do not change; only the
plumbing does.
