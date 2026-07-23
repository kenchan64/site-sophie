/* Sophie Fressingeas — interactions minimales (vanilla JS)
   1. Menu mobile (burger)
   2. Barre de navigation "affix" au défilement
   3. Carrousel d'actualités (auto-défilement, comme le flexslider d'origine)
   4. Widget flottant "Rendez-vous" (repli / dépli)
   5. Bloc "En savoir +" du bas de page
   6. Liens de partage (URL de la page courante)
*/
(function () {
  "use strict";

  /* 1. Menu mobile ------------------------------------------------------- */
  var toggle = document.querySelector(".nav-toggle");
  var collapse = document.querySelector(".nav-collapse");
  if (toggle && collapse) {
    toggle.addEventListener("click", function () {
      var open = collapse.classList.toggle("in");
      toggle.classList.toggle("is-active", open);
      toggle.setAttribute("aria-expanded", open ? "true" : "false");
    });
  }

  /* 2. Navbar affix ------------------------------------------------------ */
  var navbar = document.getElementById("navbar");
  if (navbar) {
    var onScroll = function () {
      navbar.classList.toggle("affix", window.scrollY > 50);
    };
    window.addEventListener("scroll", onScroll, { passive: true });
    onScroll();
  }

  /* 3. Carrousel d'actualités ------------------------------------------- */
  var slider = document.querySelector(".actu-slider");
  if (slider) {
    var slides = slider.querySelector(".slides");
    var count = slides.children.length;
    var index = 0;
    var interval = parseInt(slider.getAttribute("data-interval"), 10) || 7000;
    if (count > 1) {
      setInterval(function () {
        index = (index + 1) % count;
        slides.style.transform = "translateX(-" + index * 100 + "%)";
      }, interval);
    }
  }

  /* 4. Widget flottant --------------------------------------------------- */
  var flottant = document.querySelector(".flottant");
  var flTitle = document.querySelector(".flottant-title");
  if (flottant && flTitle) {
    var toggleFlottant = function () {
      flottant.classList.toggle("mini");
    };
    flTitle.addEventListener("click", toggleFlottant);
    flTitle.addEventListener("keydown", function (e) {
      if (e.key === "Enter" || e.key === " ") {
        e.preventDefault();
        toggleFlottant();
      }
    });
  }

  /* 5. Bloc "En savoir +" ------------------------------------------------ */
  var sorefPanel = document.getElementById("soref-footer-content-collapse");
  var sorefLinks = document.querySelectorAll(".toggle-soref");
  if (sorefPanel) {
    sorefLinks.forEach(function (link) {
      link.addEventListener("click", function (e) {
        e.preventDefault();
        sorefPanel.classList.toggle("show");
      });
    });
  }

  /* 6. Liens de partage -------------------------------------------------- */
  var pageUrl = encodeURIComponent(window.location.href);
  var pageTitle = encodeURIComponent(document.title);
  document.querySelectorAll("[data-share]").forEach(function (link) {
    var type = link.getAttribute("data-share");
    if (type === "facebook") {
      link.href = "https://www.facebook.com/sharer/sharer.php?u=" + pageUrl;
    } else if (type === "twitter") {
      link.href = "https://twitter.com/intent/tweet?url=" + pageUrl + "&text=" + pageTitle;
    } else if (type === "email") {
      link.href = "mailto:?subject=" + pageTitle + "&body=" + pageUrl;
    }
  });
})();
