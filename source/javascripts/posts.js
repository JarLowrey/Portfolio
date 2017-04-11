var all_collapsed = false;
var p_collapsed = false;

document.addEventListener("DOMContentLoaded", function(event) {
    document.getElementById('collapse-all-btn').addEventListener('click', collapseAllHandler, false);
    document.getElementById('collapse-p-btn').addEventListener('click', collapseParagraphHandler, false);
});

function setTagDisplay(tagName, display_type) {
    var tags = document.getElementsByTagName(tagName);
    for (var i = 0; i < tags.length; i++) {
        tags[i].style.display = display_type;
    }
}

function setClassDisplay(classNames, display_type) {
    const classes = document.getElementsByClassName(classNames)
    for (var i = 0; i < classes.length; i++) {
        classes[i].style.display = display_type;
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

function changeAllDisplay(display_type) {
    setTagDisplay('p', display_type);
    setTagDisplay('figure', display_type);
    setTagDisplay('iframe', display_type);
    setTagDisplay('pre', display_type);
    setTagDisplay('ul', display_type);
    setTagDisplay('ol', display_type);
    setClassDisplay('caps', display_type);
}

function changeCodeDisplay(display_type) {
    setTagDisplay('p', display_type);
    showParagraphsWithImagesInThem();
    setClassDisplay('caps', display_type);
}

function collapseAllHandler(event) {
    event.preventDefault(); //prevent click event from refreshing the browser

    var display_type = all_collapsed ? 'block' : 'none';
    changeAllDisplay(display_type);
    showContentConstantlyPresent();

    p_collapsed = false;
    all_collapsed = !all_collapsed;
}

function collapseParagraphHandler(event) {
    event.preventDefault(); //prevent click event from refreshing the browser

    var display_type = p_collapsed ? 'block' : 'none';
    changeAllDisplay('block');
    changeCodeDisplay(display_type);
    showContentConstantlyPresent();

    all_collapsed = false;
    p_collapsed = !p_collapsed;
}

function showContentConstantlyPresent() {
    setClassDisplay('dates', 'block');
}
