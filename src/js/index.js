import './base.js';
import './tabs.js';
import './dropdown.js';
import './tooltip.js';
import './sidebar.js';
import { toast, toastEl, toastClear } from './toast.js';

// Register the global window.teff.* APIs.
const teff = window.teff || (window.teff = {});
teff.toast = toast;
teff.toast.el = toastEl;
teff.toast.clear = toastClear;
