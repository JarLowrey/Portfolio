var slideIndices = {};

function initSlide(slide_id){
  slideIndices[slide_id] = 0;
  showSlides(slide_id);
}

// Next/previous controls
function addToSlideIndex(slide_id, n) {
  slideIndices[slide_id] += n;
  showSlides(slide_id);
}

// Thumbnail image controls
function setCurrentSlide(slide_id, n) {
  slideIndices[slide_id] = n;
  showSlides(slide_id);
}

function showSlides(slide_id) {
  var i;

  var slideContainer = document.getElementById(slide_id);
  var slides = slideContainer.getElementsByClassName("mySlides");
  var dots = slideContainer.getElementsByClassName("demo");
  var captionText = slideContainer.getElementsByClassName("caption")[0];

  var slideIndex = slideIndices[slide_id];
  if (slideIndex >= slides.length) {slideIndex = 0; }
  if (slideIndex < 0) {slideIndex = slides.length-1; }
  slideIndices[slide_id] = slideIndex;

  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";
  }
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex].style.display = "block";
  dots[slideIndex].className += " active";
  captionText.innerHTML = dots[slideIndex].alt;
}