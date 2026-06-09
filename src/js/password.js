/**
 * teff - Password visibility toggle
 * Enhances <input type="password"> with a show/hide button that flips the
 * input between password and text:
 *
 *   <input type="password">              → toggle injected on load
 *   <input type="password" data-static>  → left alone
 *
 * Progressive enhancement: without this script the field stays a plain
 * password input — no dead UI ships in the CSS-only setup. Inputs inside
 * fieldset.group are skipped (the fused group has its own trailing control).
 */

const EYE =
  '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M2.062 12.348a1 1 0 0 1 0-.696 10.75 10.75 0 0 1 19.876 0 1 1 0 0 1 0 .696 10.75 10.75 0 0 1-19.876 0"/><circle cx="12" cy="12" r="3"/></svg>';
const EYE_OFF =
  '<svg class="off" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M10.733 5.076a10.744 10.744 0 0 1 11.205 6.575 1 1 0 0 1 0 .696 10.747 10.747 0 0 1-1.444 2.49"/><path d="M14.084 14.158a3 3 0 0 1-4.242-4.242"/><path d="M17.479 17.499a10.75 10.75 0 0 1-15.417-5.151 1 1 0 0 1 0-.696 10.75 10.75 0 0 1 4.446-5.143"/><path d="m2 2 20 20"/></svg>';

const SEL = 'input[type="password"]';

const apply = (input) => {
  if (
    input.hasAttribute("data-static") ||
    input.closest("[data-password], fieldset.group")
  )
    return;

  const wrap = document.createElement("span");
  wrap.setAttribute("data-password", "");
  input.before(wrap);
  wrap.append(input);

  const btn = document.createElement("button");
  btn.type = "button";
  btn.setAttribute("aria-label", "Show password");
  btn.setAttribute("aria-pressed", "false");
  btn.innerHTML = EYE + EYE_OFF;
  btn.addEventListener("click", () => {
    const show = input.type === "password";
    input.type = show ? "text" : "password";
    btn.setAttribute("aria-pressed", String(show));
  });
  wrap.append(btn);
};

document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll(SEL).forEach(apply);

  // Enhance password inputs added later (apply() is idempotent).
  new MutationObserver((muts) => {
    for (const m of muts)
      for (const n of m.addedNodes)
        if (n.nodeType === 1) {
          if (n.matches?.(SEL)) apply(n);
          n.querySelectorAll?.(SEL).forEach(apply);
        }
  }).observe(document.body, { childList: true, subtree: true });
});
