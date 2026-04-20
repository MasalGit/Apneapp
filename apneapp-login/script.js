const form             = document.getElementById("loginForm");
const emailInput       = document.getElementById("email");
const passwordInput    = document.getElementById("password");
const emailError       = document.getElementById("emailError");
const passwordError    = document.getElementById("passwordError");
const togglePasswordBtn = document.getElementById("togglePassword");
const eyeIcon          = document.getElementById("eyeIcon");
const submitBtn        = document.getElementById("submitBtn");
const btnText          = document.getElementById("btnText");
const spinner          = document.getElementById("spinner");
const messageBox       = document.getElementById("message");
const rememberMe       = document.getElementById("rememberMe");

// Restore remembered email
const savedEmail = localStorage.getItem("rememberedEmail");
if (savedEmail) {
  emailInput.value = savedEmail;
  rememberMe.checked = true;
}

// Toggle password visibility
togglePasswordBtn.addEventListener("click", function () {
  const isPassword = passwordInput.type === "password";
  passwordInput.type = isPassword ? "text" : "password";
  eyeIcon.className = isPassword ? "fas fa-eye-slash" : "fas fa-eye";
});

// Clear field errors on input
emailInput.addEventListener("input", () => {
  emailError.textContent = "";
  emailInput.classList.remove("error");
});

passwordInput.addEventListener("input", () => {
  passwordError.textContent = "";
  passwordInput.classList.remove("error");
});

function isValidEmail(email) {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

function showMessage(text, type) {
  messageBox.textContent = text;
  messageBox.className = "message-box " + type;
  messageBox.hidden = false;
}

function setLoading(loading) {
  submitBtn.disabled = loading;
  btnText.hidden = loading;
  spinner.hidden = !loading;
}

form.addEventListener("submit", function (e) {
  e.preventDefault();
  messageBox.hidden = true;

  const email    = emailInput.value.trim();
  const password = passwordInput.value;
  let valid = true;

  // Validate email
  if (!email) {
    emailError.textContent = "Sähköposti on pakollinen";
    emailInput.classList.add("error");
    valid = false;
  } else if (!isValidEmail(email)) {
    emailError.textContent = "Virheellinen sähköpostiosoite";
    emailInput.classList.add("error");
    valid = false;
  }

  // Validate password
  if (!password) {
    passwordError.textContent = "Salasana on pakollinen";
    passwordInput.classList.add("error");
    valid = false;
  } else if (password.length < 6) {
    passwordError.textContent = "Salasanan on oltava vähintään 6 merkkiä";
    passwordInput.classList.add("error");
    valid = false;
  }

  if (!valid) return;

  // Remember me
  if (rememberMe.checked) {
    localStorage.setItem("rememberedEmail", email);
  } else {
    localStorage.removeItem("rememberedEmail");
  }

  setLoading(true);

  // Simulate login request (replace with real API call)
  setTimeout(() => {
    setLoading(false);
    showMessage("Kirjautuminen onnistui! Ohjataan...", "success");
    setTimeout(() => {
      window.location.href = "dashboard.html";
    }, 1000);
  }, 1500);
});