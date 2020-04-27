// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"
import axios from "axios"
import Rails from "@rails/ujs"

export default class extends Controller {
  static targets = ["icon"]

  initialize() {
    this.clicked = false;
  }

  heart(e) {
    e.preventDefault();
    
    const csrfToken = document.querySelector('[name=csrf-token]').content
    axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken

    let item_id = document.querySelector('#item_id').value;

    // Rails.ajax({
    //   url: `/api/v1/items/${item_id}/favorite`,
    //   type: 'POST',
    //   success: resp => {
    //     if(resp.status === 'favorited') {
    //         this.iconTarget.classList.remove('far');
    //         this.iconTarget.classList.add('fas');
    //       } else {
    //         this.iconTarget.classList.remove('fas');
    //         this.iconTarget.classList.add('far');
    //       }
    //   },
    //   error: err => {
    //     console.log(err)
    //   }
    // })

    
    axios.post(`/api/v1/items/${item_id}/favorite`) 
      .then(resp => {
        debugger
        if(resp.data.status === 'favorited') {
          this.iconTarget.classList.remove('far');
          this.iconTarget.classList.add('fas');
        } else {
          this.iconTarget.classList.remove('fas');
          this.iconTarget.classList.add('far');
        }
      })
      .catch(function(err) {
        console.log(err);
      })

    // if (this.clicked) {
    //   this.iconTarget.classList.remove('fas')  // s = solid
    //   this.iconTarget.classList.add('far')     // r = regular
    //   this.clicked = false
    // } else {
    //   this.iconTarget.classList.remove('far')
    //   this.iconTarget.classList.add('fas')
    //   this.clicked = true
    // }
  }
}