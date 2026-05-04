const languageKey = "apneapp-language";
const defaultLanguage = "fi";

const translations = {
  fi: {
    dashboardTitle: "Yleiskatsaus",
    settingsTitle: "Asetukset",
    reportsTitle: "Raportit",
    graphTitle: "Kaavio",
    chartTitle: "Unen kesto ja LF/HF",
    period7days: "7 pv",
    period30days: "30 pv",
    period90days: "90 pv",
    period365days: "365 pv",
    user: "Käyttäjä",
    logout: "Kirjaudu ulos",

    sidebarDashboard: "Yleiskatsaus",
    sidebarGraph: "Kaavio",
    sidebarReports: "Raportit",
    sidebarSettings: "Asetukset",
    sidebarHeart: "Sykemittaus",
    sidebarStats: "Tilastot",
    sidebarSleep: "Unijaksot",

    settingsSubtitle: "Hallitse tilin ja sovelluksen asetuksia.",
    settingsOptions: "Asetusvaihtoehdot",
    profileTitle: "Käyttäjäprofiili",
    profileText: "Päivitä profiilitiedot, sähköpostiosoite ja muut henkilökohtaiset asetukset.",
    profileButton: "Muokkaa profiilia",
    notificationsTitle: "Ilmoitukset",
    notificationsText: "Hallinnoi ilmoituksia ja muistutuksia, jotka liittyvät uniseurantaan ja raportteihin.",
    notificationsButton: "Muokkaa ilmoituksia",
    notificationsCardTitle: "Ilmoitukset",
    notificationsCardText: "Valitse, mitä ilmoituksia näytetään yläpalkin kellokuvakkeessa.",
    riskNotifTitle: "Riskivaroitukset",
    riskNotifText: "Näytä ilmoitus, jos uniapneariski on kohonnut.",
    sleepNotifTitle: "Unen kesto",
    sleepNotifText: "Näytä ilmoitus, jos unen kesto jää alle suosituksen.",
    hrvNotifTitle: "HRV / RMSSD",
    hrvNotifText: "Näytä ilmoitus, jos palautumisarvo on alle viitearvon.",
    privacyTitle: "Tietosuoja",
    privacyText: "Tarkista tietosuoja-asetukset ja hallitse, miten tietojasi käytetään sovelluksessa.",
    privacyButton: "Tietosuoja-asetukset",
    appearanceTitle: "Sovelluksen ulkoasu",
    appearanceText: "Muokkaa sovelluksen käyttöä itsellesi sopivammaksi.",
    darkModeTitle: "Tumma tila",
    darkModeText: "Vaihda sovellus vaalean ja tumman teeman välillä.",
    languageTitle: "Kieli",
    languageText: "Valitse sovelluksen kieli.",
    timeFormatTitle: "Aikamuoto",
    timeFormatText: "Näytä kellonajat 24h- tai 12h-muodossa.",
    settingsNote: "Asetukset tallennetaan selaimen localStorage-muistiin. Seuraavaksi tähän voidaan lisätä oikea profiilin muokkaus, ilmoitusasetukset ja tietosuoja-asetusten tallennus backendin kautta.",

    sleepApneaRisk: "Uniapneariski: Kohonnut",
    latestAnalysis: "Viimeisin analyysi tänä yönä klo 03:14",
    viewReport: "Katso raportti",
    sleepDuration: "Unen kesto",
    apneaEvents: "Apnea-tapahtumat",
    belowReference: "Alle viitearvon",
    normal: "Normaali",
    belowRecommendation: "Alle suosituksen",
    high: "Korkea",
    lastNight: "Viimeisin yö",
    sleepTime: "Nukkumisaika",
    deepSleep: "Syvä uni",
    remSleep: "REM-uni",
    disturbances: "Häiriöt",
    bodyTemperature: "Kehon lämpötila",
    quickActions: "Nopeat toiminnot",
    openView: "Avaa näkymä",
    openReports: "Avaa raportit",
    editSettings: "Muokkaa asetuksia",
    viewVisualization: "Tarkastele visualisointia",
    viewSummary: "Katso yhteenveto",
    manageApplication: "Hallitse sovellusta",

    reportsSubtitle: "Lataa ja tarkastele tärkeimpiä analyysiyhteenvetoja.",
    availableReports: "Saatavilla olevat raportit",
    sleepSummary: "Uniyhteenveto",
    sleepSummaryText: "Kooste viimeisimmän yön unidatasta, unen kestosta ja palautumisesta.",
    hrvAnalysis: "HRV-analyysi",
    hrvText: "Sykevälivaihteluun perustuva analyysi, joka tukee uniapneariskin arviointia.",
    doctorReport: "Lääkäriraportti",
    doctorText: "Tulevaisuudessa jaettava yhteenveto, jonka voi näyttää terveydenhuollon ammattilaiselle.",
    openReport: "Avaa raportti",
    reportsNote: "Raporttien sisältö on vielä osittain kehitysvaiheessa. Tähän näkymään voidaan myöhemmin lisätä ladattavat PDF-raportit, tarkemmat mittaustulokset ja analyysikaaviot.",

    graphMainTitle: "Unen kesto ja Riskiarvio",
    active: "Aktiivinen"
  },

  en: {
    dashboardTitle: "Overview",
    settingsTitle: "Settings",
    reportsTitle: "Reports",
    graphTitle: "Chart",
    chartTitle: "Sleep duration and LF/HF",
    period7days: "7 days",
    period30days: "30 days",
    period90days: "90 days",
    period365days: "365 days",
    user: "User",
    logout: "Log out",

    sidebarDashboard: "Overview",
    sidebarGraph: "Chart",
    sidebarReports: "Reports",
    sidebarSettings: "Settings",
    sidebarHeart: "Heart measurement",
    sidebarStats: "Statistics",
    sidebarSleep: "Sleep periods",

    settingsSubtitle: "Manage your account and application settings.",
    settingsOptions: "Settings options",
    profileTitle: "User profile",
    profileText: "Update your profile information, email address and other personal settings.",
    profileButton: "Edit profile",
    notificationsTitle: "Notifications",
    notificationsText: "Manage notifications and reminders related to sleep tracking and reports.",
    notificationsButton: "Edit notifications",
    notificationsCardTitle: "Notifications",
    notificationsCardText: "Choose which notifications are displayed in the top bar bell icon.",
    riskNotifTitle: "Risk alerts",
    riskNotifText: "Show notification if sleep apnea risk is elevated.",
    sleepNotifTitle: "Sleep duration",
    sleepNotifText: "Show notification if sleep duration falls below recommendation.",
    hrvNotifTitle: "HRV / RMSSD",
    hrvNotifText: "Show notification if recovery value is below reference.",
    privacyTitle: "Privacy",
    privacyText: "Review privacy settings and manage how your data is used in the application.",
    privacyButton: "Privacy settings",
    appearanceTitle: "Application appearance",
    appearanceText: "Customize the application to better fit your preferences.",
    darkModeTitle: "Dark mode",
    darkModeText: "Switch the application between light and dark theme.",
    languageTitle: "Language",
    languageText: "Choose the application language.",
    timeFormatTitle: "Time format",
    timeFormatText: "Show times in 24h or 12h format.",
    settingsNote: "Settings are saved in the browser localStorage. Later this view can include real profile editing, notification settings and privacy settings saved through the backend.",

    sleepApneaRisk: "Sleep apnea risk: Elevated",
    latestAnalysis: "Latest analysis tonight at 03:14",
    viewReport: "View report",
    sleepDuration: "Sleep duration",
    apneaEvents: "Apnea events",
    belowReference: "Below reference value",
    normal: "Normal",
    belowRecommendation: "Below recommendation",
    high: "High",
    lastNight: "Last night",
    sleepTime: "Sleep time",
    deepSleep: "Deep sleep",
    remSleep: "REM sleep",
    disturbances: "Disturbances",
    bodyTemperature: "Body temperature",
    quickActions: "Quick actions",
    openView: "Open view",
    openReports: "Open reports",
    editSettings: "Edit settings",
    viewVisualization: "View visualization",
    viewSummary: "View summary",
    manageApplication: "Manage application",

    reportsSubtitle: "Download and view the most important analysis summaries.",
    availableReports: "Available reports",
    sleepSummary: "Sleep summary",
    sleepSummaryText: "Summary of the latest night’s sleep data, sleep duration and recovery.",
    hrvAnalysis: "HRV analysis",
    hrvText: "Heart rate variability based analysis that supports sleep apnea risk assessment.",
    doctorReport: "Doctor report",
    doctorText: "A future shareable summary that can be shown to a healthcare professional.",
    openReport: "Open report",
    reportsNote: "Report content is still partly under development. Later this view can include downloadable PDF reports, more detailed measurement results and analysis charts.",

    graphMainTitle: "Sleep duration and risk estimate",
    active: "Active"
  }
};

const fiToEn = {
  "Yleiskatsaus": "Overview",
  "Kaavio": "Chart",
  "Raportit": "Reports",
  "Asetukset": "Settings",
  "Käyttäjä": "User",
  "Kirjaudu ulos": "Log out",
  "Sykemittaus": "Heart measurement",
  "Tilastot": "Statistics",
  "Unijaksot": "Sleep periods",
  "Uniapneariski: Kohonnut": "Sleep apnea risk: Elevated",
  "Viimeisin analyysi tänä yönä klo 03:14": "Latest analysis tonight at 03:14",
  "Katso raportti": "View report",
  "Unen kesto": "Sleep duration",
  "Apnea-tapahtumat": "Apnea events",
  "Alle viitearvon": "Below reference value",
  "Normaali": "Normal",
  "Alle suosituksen": "Below recommendation",
  "Korkea": "High",
  "Viimeisin yö": "Last night",
  "Nukkumisaika": "Sleep time",
  "Syvä uni": "Deep sleep",
  "REM-uni": "REM sleep",
  "Häiriöt": "Disturbances",
  "Kehon lämpötila": "Body temperature",
  "Nopeat toiminnot": "Quick actions",
  "Avaa näkymä": "Open view",
  "Avaa raportit": "Open reports",
  "Muokkaa asetuksia": "Edit settings",
  "Tarkastele visualisointia": "View visualization",
  "Katso yhteenveto": "View summary",
  "Hallitse sovellusta": "Manage application",
  "Unen kesto ja Riskiarvio": "Sleep duration and risk estimate",
  "Aktiivinen": "Active",
  "Saatavilla olevat raportit": "Available reports",
  "Uniyhteenveto": "Sleep summary",
  "HRV-analyysi": "HRV analysis",
  "Lääkäriraportti": "Doctor report",
  "Avaa raportti": "Open report"
};

const enToFi = Object.fromEntries(
  Object.entries(fiToEn).map(([fi, en]) => [en, fi])
);

function translateTextNodes(targetLanguage) {
  const map = targetLanguage === "en" ? fiToEn : enToFi;

  const walker = document.createTreeWalker(
    document.body,
    NodeFilter.SHOW_TEXT,
    {
      acceptNode(node) {
        const parent = node.parentElement;
        if (!parent) return NodeFilter.FILTER_REJECT;

        const tag = parent.tagName;
        if (tag === "SCRIPT" || tag === "STYLE") return NodeFilter.FILTER_REJECT;

        const text = node.nodeValue.trim();
        if (!text) return NodeFilter.FILTER_REJECT;

        return NodeFilter.FILTER_ACCEPT;
      }
    }
  );

  const nodes = [];
  while (walker.nextNode()) {
    nodes.push(walker.currentNode);
  }

  nodes.forEach((node) => {
    const original = node.nodeValue;
    const trimmed = original.trim();

    if (map[trimmed]) {
      node.nodeValue = original.replace(trimmed, map[trimmed]);
    }
  });
}

function applyTranslations() {
  const currentLanguage = localStorage.getItem(languageKey) || defaultLanguage;
  const selected = translations[currentLanguage] || translations.fi;

  document.querySelectorAll("[data-i18n]").forEach((element) => {
    const key = element.getAttribute("data-i18n");

    if (selected[key]) {
      element.textContent = selected[key];
    }
  });

  translateTextNodes(currentLanguage);
  document.documentElement.lang = currentLanguage;
}

window.applyTranslations = applyTranslations;

document.addEventListener("DOMContentLoaded", applyTranslations);