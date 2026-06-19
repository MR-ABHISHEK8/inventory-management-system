
    const toggle = document.getElementById("toggle");
    const sidebar = document.getElementById("sidebar");
    const main = document.getElementById("main");

    toggle.addEventListener("click", () => {
    sidebar.classList.toggle("close");
    main.classList.toggle("expand");
});


