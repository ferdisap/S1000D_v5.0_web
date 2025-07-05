document.getElementById('search_element').onkeyup = delay;

let registered_element;

// config
let count = 1;
let maxLimit = 5;
let asc = true;
let resultContainer = document.getElementById('result-container');
let caseSentitive = false;

let focusel = undefined;

let tocIframe = document.querySelector('iframe[name="toc"]');
let contentIframe = document.querySelector('iframe[name="content"]');

window.addEventListener('load', () => {
    [...document.getElementsByTagName('iframe')].forEach(iframe => {
        iframe.contentDocument.addEventListener('click', (event) => {
            if (!event.target.classList.contains('search-container')) {
                focusel = undefined;
                hide_result_display();
            }
        });
    })
})

document.getElementById('search_element').onclick = show_result_display;
document.getElementById('search_button').onclick = (event) => search(document.getElementById('search_element').value);

fetch("./elements/registered_elements.json")
    .then(rsp => rsp.json())
    .then(rst => registered_element = rst);

let to = 0;

function delay(event) {
    clearTimeout(to)
    focusel = event.target;
    if (searchKeyAnalyzer(event) === 13) {
        let str = event.target.value;
        to = setTimeout(search.bind(null, str), 300)
    }
}

function reset_count() {
    count = 1;
}

function search(str) {
    reset_count();
    let result = engine(str);
    if(result.length){
        remove_result_display();
        install_result_display(result);
        show_result_display();
    }
}

function install_result_display(result) {
    remove_result_display();
    let origin = window.location.origin;
    result.forEach(el => {
        let a = document.createElement('a');
        a.href = `${origin}/Elements/${el}.xml`;
        a.innerText = el;
        a.setAttribute('class', 'result-item');
        a.onkeydown = keyAnalizer;
        a.onclick = clickResult;
        resultContainer.appendChild(a);
    });
}

function remove_result_display() {
    resultContainer.innerHTML = '';
}
function hide_result_display() {
    resultContainer.style.display = 'none'
}
function show_result_display() {
    resultContainer.style.display = 'block'
}

function engine(str) {
    result = [];
    top.regEl = registered_element

    if (!asc) registered_element = registered_element.reverse();

    let i = 0;
    if(registered_element.includes(str)){
        result.push(str);
        count++;
    } else {
        while (i < registered_element.length) {
            let el = registered_element[i];
            if(!caseSentitive) {
                // karena registered_elemen ada huruf besar dan kecilnya
                el = el.toLowerCase();
                str = str.toLowerCase();
            } 
            if (el.includes(str)) {
                result.push(registered_element[i]);
                count++;
            }
            if (count > maxLimit) break;
            i++;
        }
    }
    return result;
}

function searchKeyAnalyzer(event) {
    // keycode = 40: ArrowDown, 38: ArrowUp 191: /, 13: Enter, 27: Escape
    switch (event.keyCode) {
        case 40:
            scrollDown();
            break;
        case 38:
            scrollUp();
            break;
        case 27:
            hide_result_display();
            break;
        case 13:
            return 13;
        default:
            return 13;
            break;
    }
}

function keyAnalizer(event) {
    switch (event.keyCode) {
        case 40:
            scrollDown();
            break;
        case 38:
            scrollUp();
            break;
        case 191:
            inputFocus();
            break;
        case 13:
            event.preventDefault();
            openElement(event.target.href);
            break;
        default:
            break;
    }
}

function clickResult(event){
    event.preventDefault();
    openElement(event.target.closest("a").href);
}

function inputFocus() {
    setBorder(focusel, 0);
    focusel = document.getElementById('search_element');
    focusel.focus();
    show_result_display();
}

function scrollDown() {
    if (focusel.tagName === 'INPUT') {
        if (resultContainer.firstElementChild) {
            focusel = resultContainer.firstElementChild;
            setBorder(focusel, 1);
        };
    } else {
        setBorder(focusel, 0)
        if (focusel.nextElementSibling) focusel = focusel.nextElementSibling;
        else focusel = resultContainer.firstElementChild;
        setBorder(focusel, 1)
    }
    focusel.focus();
}

function scrollUp() {
    if (focusel.tagName === 'INPUT') {
        if (resultContainer.firstElementChild) {
            focusel = resultContainer.lastElementChild;
        }
    } else {
        setBorder(focusel, 0)
        if (focusel.previousElementSibling) focusel = focusel.previousElementSibling;
        else focusel = resultContainer.lastElementChild;
        setBorder(focusel, 1)
    }
    focusel.focus();
}

function setBorder(el, state) {
    if (state) {
        el.style.backgroundColor = "rgb(129,190,247)";
    } else {
        el.style.backgroundColor = 'unset';
    }
}

function openElement(url){
    if(tocIframe.src != window.location.origin + "/toc/tocElem.xml") tocIframe.src = window.location.origin + "/toc/tocElem.xml";
    contentIframe.src = url;
    hide_result_display();
}
