/**
 * teff - Attention shake
 * Imperative trigger for the [data-shake] animation:
 *
 *   teff.shake(input)   // e.g. on a rejected login attempt
 *
 * Re-adds the attribute with a reflow in between so repeat calls restart a
 * mid-flight animation, and removes it on animationend so the element is
 * left clean.
 */

export const shake = (el) => {
  if (!el) return;
  el.removeAttribute("data-shake");
  void el.offsetWidth;
  el.setAttribute("data-shake", "");
  const done = (e) => {
    if (e.target !== el) return;
    el.removeAttribute("data-shake");
    el.removeEventListener("animationend", done);
  };
  el.addEventListener("animationend", done);
};
