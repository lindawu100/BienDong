import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ["content", "submit"]

    check(e) {
        if(this.contentTarget.value.length >= 2) {
            // comment文字兩個以上時，移除disable，讓submit可以按
            this.submitTarget.disabled = false
        }
    }
}