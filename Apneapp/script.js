// ===== GLOBAL THEME LOADER =====
function applyGlobalTheme() {
  const savedTheme = localStorage.getItem("apneapp-theme") || "light";

  if (savedTheme === "dark") {
    document.body.classList.add("dark-mode");
  } else {
    document.body.classList.remove("dark-mode");
  }
}

applyGlobalTheme();


// ===== GLOBAL LOGOUT =====
function logout() {
  localStorage.removeItem("token");
  window.location.href = "index.html";
}


// ===== LOGIN PAGE CODE =====
const form              = document.getElementById("loginForm");
const emailInput        = document.getElementById("email");
const passwordInput     = document.getElementById("password");
const emailError        = document.getElementById("emailError");
const passwordError     = document.getElementById("passwordError");
const togglePasswordBtn = document.getElementById("togglePassword");
const eyeIcon           = document.getElementById("eyeIcon");
const submitBtn         = document.getElementById("submitBtn");
const btnText           = document.getElementById("btnText");
const spinner           = document.getElementById("spinner");
const messageBox        = document.getElementById("message");
const rememberMe        = document.getElementById("rememberMe");

const API_URL = "https://ryhma5-server.swedencentral.cloudapp.azure.com/api/kubios/login"

if (form) {
  // Restore remembered email
  const savedEmail = localStorage.getItem("rememberedEmail");
  if (savedEmail && emailInput && rememberMe) {
    emailInput.value = savedEmail;
    rememberMe.checked = true;
  }

  // Toggle password visibility
  if (togglePasswordBtn && passwordInput && eyeIcon) {
    togglePasswordBtn.addEventListener("click", function () {
      const isPassword = passwordInput.type === "password";
      passwordInput.type = isPassword ? "text" : "password";
      eyeIcon.className = isPassword ? "fas fa-eye-slash" : "fas fa-eye";
    });
  }

  // Clear field errors on input
  if (emailInput && emailError) {
    emailInput.addEventListener("input", () => {
      emailError.textContent = "";
      emailInput.classList.remove("error");
    });
  }

  if (passwordInput && passwordError) {
    passwordInput.addEventListener("input", () => {
      passwordError.textContent = "";
      passwordInput.classList.remove("error");
    });
  }

  function isValidEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
  }

  function showMessage(text, type) {
    if (!messageBox) return;
    messageBox.textContent = text;
    messageBox.className = "message-box " + type;
    messageBox.hidden = false;
  }

  function setLoading(loading) {
    if (!submitBtn || !btnText || !spinner) return;
    submitBtn.disabled = loading;
    btnText.hidden = loading;
    spinner.hidden = !loading;
  }

  form.addEventListener("submit", async function (e) {
    e.preventDefault();

    if (messageBox) {
      messageBox.hidden = true;
    }

    const email = emailInput ? emailInput.value.trim() : "";
    const password = passwordInput ? passwordInput.value : "";

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

    // Remember email
    if (rememberMe && rememberMe.checked) {
      localStorage.setItem("rememberedEmail", email);
    } else {
      localStorage.removeItem("rememberedEmail");
    }

    setLoading(true);

    try {
      const res = await fetch(API_URL, {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          username: email,
          password: password
        })
      });

      setLoading(false);

      if (!res.ok) {
        const errText = await res.text();
        showMessage("Kirjautuminen epäonnistui: " + errText, "error");
        return;
      }

      const data = await res.json();

      const token = data.token || data.access_token || data.jwt;

      if (!token) {
        showMessage("Tokenia ei saatu backendistä", "error");
        return;
      }

      localStorage.setItem("token", token);

      showMessage("Kirjautuminen onnistui! Ohjataan...", "success");

      setTimeout(() => {
        window.location.href = "dashboard.html";
      }, 800);

    } catch (err) {
      setLoading(false);
      console.error(err);
      showMessage("Palvelinvirhe", "error");
    }
  });
}