var all_collapsed = false;
var p_collapsed = false;

document.addEventListener("DOMContentLoaded", function(event) {
    document.getElementById('collapse-all-btn').addEventListener('click', collapseAllHandler, false);
    document.getElementById('collapse-p-btn').addEventListener('click', collapseParagraphHandler, false);
});

function changeTagDisplay(tagName, display) {
    var tags = document.getElementsByTagName(tagName);
    for (var i = 0; i < tags.length; i++) {
        tags[i].style.display = display;
    }
}

function showParagraphsWithImagesInThem() {
    var tags = document.getElementsByTagName('p');
    for (var i = 0; i < tags.length; i++) {
        var tag = tags[i];
        for (var j = 0; j < tag.children.length; j++) {
            var child = tag.children[j];
            if (child.nodeType === 1 && child.tagName.toLowerCase() === 'img') {
                tag.style.display = 'block';
            }
        }
    }
}

function changeAllDisplay(display) {
    changeTagDisplay('p', display);
    changeTagDisplay('pre', display);
    changeTagDisplay('ul', display);
    changeTagDisplay('ol', display);
}

function changeCodeDisplay(display) {
    changeTagDisplay('p', display);
    showParagraphsWithImagesInThem();
}

function collapseAllHandler() {
    event.preventDefault(); //prevent click event from refreshing the browser

    var display = all_collapsed ? 'block' : 'none';
    changeAllDisplay(display);
    showContentConstantlyPresent();

    p_collapsed = false;
    all_collapsed = !all_collapsed;
}

function collapseParagraphHandler() {
    event.preventDefault(); //prevent click event from refreshing the browser

    var display = p_collapsed ? 'block' : 'none';
    changeAllDisplay('block');
    changeCodeDisplay(display);
    showContentConstantlyPresent();

    all_collapsed = false;
    p_collapsed = !p_collapsed;
}

function showContentConstantlyPresent() {
    document.getElementById('author').style.display = 'block';
}
