let getRandomArticle = (jsonArray) => {
    let randomNumber = Math.floor(Math.random() * jsonArray.length)
    let list = document.getElementById('random')
    let pic = document.getElementById('pic')
    list.innerHTML += `<h5>${jsonArray[randomNumber].title}</h5>`
    list.innerHTML += `<p>${jsonArray[randomNumber].description}</p>`
    list.innerHTML += `<li><a target="_blank" href=${jsonArray[randomNumber].url}>View Article</a></li>`
    pic.innerHTML = `<div><img src=${jsonArray[randomNumber].image}><div>`
}

let fetchArticles = () => {
    fetch("/articles.json")
    .then((response) => {
        if (response.ok) {
          return response
        } else {
          console.log('error')
        }
    })
    .then((response) => {
        return response.json()
     })
    .then((response) =>{
        getRandomArticle(response)
    })
 }

let replaceArticle = () => {
  let list = document.getElementById('random')
  list.innerHTML = ''
  fetchArticles()
}
let button = document.getElementById('get_article')
button.addEventListener('click', replaceArticle)
