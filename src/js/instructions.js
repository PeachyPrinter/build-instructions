  $('selector').loupe({
      width: 200, 
      height: 150, 
      loupe: 'loupe' 
  });

  function show_step(section_id) {
    var section = document.getElementById(section_id);
    var section_onclick = section.onclick;
    section.onclick();
    document.getElementById("big").onclick();
  }

  function set_images(images, ref) {
    slideTo(0);
    currentImage = 0;
    //alert("Current image:" + currentImage);
    var section_id = ""
    if (typeof(ref) != "undefined") {
      section_id = ref.getAttribute('id');
    }
    var next_step = "";
    if (typeof(ref) != "undefined") {
      if (ref.nextElementSibling != null) {
        next_step = ref.nextElementSibling.getAttribute('id');
      }
    }
    $('.instructions').hide();
    $('.slider-container').show();
    var imageSlider = document.getElementById("image_slider");
    while(imageSlider.firstChild) {
      imageSlider.removeChild(imageSlider.firstChild);
    }

    var urls = [];
    for (var i = 0; i < images.length; i++) {
      var urlAndDescrip = [];
      urlAndDescrip.push(images[i]);
      var section = document.getElementById(section_id);
      var onclickstr = "show_step('" + next_step + "')";
      var nextStepLink = ""
      if (next_step != "") {
        nextStepLink = "<a href='#' onclick=" + onclickstr + ">Next Step</a>";
      }
      if (section != null) {
        urlAndDescrip.push(section.innerHTML.split("\n")[0] + "&nbsp;" + nextStepLink);
      }
      urls.push(urlAndDescrip);
    }

    if (section != null) {
      $('#slider-description').html(section.getAttribute('title'));
    }

    for (var i = 0; i < images.length; i++) {
      var li = document.createElement("li");
      var imgElem = document.createElement("img");
      imgElem.className = "mag";
      var url = images[i];
      imgElem.src = images[i];
      imgElem.width = 522;
      imgElem.height = 350;

      li.appendChild(imgElem);
      imageSlider.appendChild(li);
    }
    var pager = document.getElementById("pager");
    while (pager.firstChild) {
      pager.removeChild(pager.firstChild);
    }

    init();
    document.getElementById("big").onclick = function() { 
      jQuery.slimbox(urls, 0, {loop: true, initialHeight: "50%", initialWidth: "90%" }) 
    };
    document.getElementById("magnifier").onclick = function() { 
      $('.mag').loupe(); 
    };
  }
//1. set ul width 
//2. image when click prev/next button
var ul;
var liItems;
var imageNumber;
var imageWidth;
var prev, next;
var currentPostion = 0;
var currentImage = 0;

function init() {
    ul = document.getElementById('image_slider');
    liItems = ul.children;
    imageNumber = liItems.length;
    imageWidth = liItems[0].children[0].clientWidth;
    ul.style.width = parseInt(imageWidth * imageNumber) + 'px';
    prev = document.getElementById("prev");
    next = document.getElementById("next");
    generatePager(imageNumber);
    var pagerDiv = document.getElementById('pager');
    prev.onclick = function(){ onClickPrev();};
    next.onclick = function(){ onClickNext();};
    pagerDiv.style.opacity = '0.0';
    prev.style.display = 'none';
    next.style.display = 'none';
    if (liItems.length > 1) {
      pagerDiv.style.opacity = '0.6';
      prev.style.display = 'block';
      next.style.display = 'block';
    }
    $('slider-container').hide();
}

function animate(opts) {
  var start = new Date;
  var id = setInterval(function() {
    var timePassed = new Date - start;
    var progress = timePassed / opts.duration;
    if (progress > 1){
      progress = 1;
    }
    var delta = opts.delta(progress);
    opts.step(delta);
    if (progress == 1) {
      clearInterval(id);
      opts.callback();
    }
  }, opts.delay || 17);
}

function slideTo(imageToGo) {
  var direction;
  var numOfImageToGo = Math.abs(imageToGo - currentImage);
  // slide toward left

  direction = currentImage > imageToGo ? 1 : -1;
  currentPostion = -1 * currentImage * imageWidth;
  var opts = {
    duration:1000,
    delta:function(p){ return p; },
    step:function(delta) {
      ul.style.left = parseInt(currentPostion + direction * delta * imageWidth * numOfImageToGo) + 'px';
    },
    callback:function() { currentImage = imageToGo; }  
  };
  animate(opts);
}

function onClickPrev() {
  if (currentImage == 0) {
    slideTo(imageNumber - 1);
  }     
  else {
    slideTo(currentImage - 1);
  }    
}

function onClickNext() {
  if (currentImage == imageNumber - 1){
    slideTo(0);
  }    
  else {
    slideTo(currentImage + 1);
  }    
}

function generatePager(imageNumber){  
  var pageNumber;
  var pagerDiv = document.getElementById('pager');
  for (i = 0; i < imageNumber; i++){
    var li = document.createElement('li');
    pageNumber = document.createTextNode(parseInt(i + 1));
    li.appendChild(pageNumber);
    pagerDiv.appendChild(li);
    li.onclick = function(i) {
      return function(){
        slideTo(i);
      }
    }(i);
  }  
  var computedStyle = document.defaultView.getComputedStyle(li, null);
  //border width 1px; offsetWidth = 22
  var liWidth = parseInt(li.offsetWidth);
  var liMargin = parseInt(computedStyle.margin.replace('px',""));
  pagerDiv.style.width = parseInt((liWidth + liMargin * 2) * imageNumber) + 'px';
}

window.onload = init;

