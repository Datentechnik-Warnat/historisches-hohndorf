var splideData;
if (splideData) {
  document.addEventListener("DOMContentLoaded", function (e) {
    for (let id of splideData) {
      new Splide("#" + id).mount();
    }
  });
}
