
const clickMe = document.querySelector('.click-me');
clickMe.addEventListener('click', _ => {
    const pugImage = document.querySelector('.pug');
    pugImage.src = pugImage.src.endsWith('pug1.jpg') ? '/static/img/pug2.jpg' : '/static/img/pug1.jpg';
});
