// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"
import {Socket} from "phoenix"
import NProgress from "nprogress"
import {LiveSocket} from "phoenix_live_view"
import {InitToast} from "./init_toast.js"

let Hooks = {}

Hooks.SetSession = {
    DEBOUNCE_MS: 2000,

    // Called when a LiveView is mounted, if it includes an element that uses this hook.
    mounted() {
        // `this.el` is the form.
        this.el.addEventListener("input", (e) => {
            clearTimeout(this.timeout)
            this.timeout = setTimeout(() => {
                // Ajax request to update session.
                fetch(`/api/session?${e.target.name}=${encodeURIComponent(e.target.value)}`, { method: "post" })

                // Optionally, include this so other LiveViews can be notified of changes.
                this.pushEventTo(".phx-hook-subscribe-to-session", "updated_session_data", [e.target.name, e.target.value])
            }, this.DEBOUNCE_MS)
        })
    },
}

Hooks.InitToast = InitToast

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
// let liveSocket = new LiveSocket("/live", Socket, {hooks: Hooks})
let liveSocket = new LiveSocket("/live", Socket, {
  hooks: Hooks,
  params: {_csrf_token: csrfToken},
  dom: {
    onBeforeElUpdated(from, to){
      if(from.__x){ window.Alpine.clone(from.__x, to) }
    }
  }
})


// Show progress bar on live navigation and form submits
window.addEventListener("phx:page-loading-start", info => NProgress.start())
window.addEventListener("phx:page-loading-stop", info => NProgress.done())


Hooks.Card = {
    mounted(){
        this.el.addEventListener("dragstart", e => {
            console.log("drag card started")

            this.el.style.opacity = "0.5"

            let card_type =  this.el.attributes.data_card_type.value

            e.dataTransfer.setData("dragged_card_id", this.el.id)
            e.dataTransfer.setData("dragged_card_type", card_type)

        });

        this.el.addEventListener("dragend", e => {
            this.el.className = "card"
            console.log("drag card end")
        });

        // this.el.addEventListener("dragover", e => {
        //     this.el.className = "card above"
        //     e.preventDefault();
        //     console.log("drag over card, card id")
        // });

        // this.el.addEventListener("dragleave", e => {
        //     e.preventDefault();
        //     this.el.className = "card"
        //     console.log("drag over card, card id")
        // });

        this.el.addEventListener("drop", e => {
            let card_type =  this.el.attributes.data_card_type.value

            // # send which card id
            // # send drop on which card id
            // collect from car through data transfer

            let payload = {}
            payload.drag_card_id = e.dataTransfer.getData("dragged_card_id")
            payload.drag_card_type = e.dataTransfer.getData("dragged_card_type")
            // payload.drop_card_id = this.el.id;
            // payload.drop_card_type = card_type

            // this.pushEvent("move-card", payload);
        });
    }
}


Hooks.Stall = {
    mounted(){
        // this.el.addEventListener("dragstart", e => {
        //     console.log("drag card started")
        //     this.el.style.opacity = "0.5"
        //     let card_type =  this.el.attributes.data_card_type.value
        //     e.dataTransfer.setData("dragged_card_id", this.el.id)
        //     e.dataTransfer.setData("dragged_card_type", card_type)
        // });

        this.el.addEventListener("dragend", e => {
            // this.el.className = "card-above"
            console.log("drag card end - stall")
        });

        this.el.addEventListener("dragover", e => {
            // this.el.className = "card-over-stall"
            this.el.classList.add("card-over-stall");
            e.preventDefault();
            console.log("card hovered in Stall")
        });

        this.el.addEventListener("dragleave", e => {
            e.preventDefault();
            // this.el.classList.add("mystyle");
            this.el.classList.remove("card-over-stall");
           // this.el.className = "card-left-stall"
            console.log("drag over card, card id")
        });

        this.el.addEventListener("drop", e => {

            // let card_type =  this.el.attributes.data_card_type.value;

            // # send which card id
            // # send drop on which card id
            // collect from car through data transfer
            let phx_target = this.el.getAttribute("phx-target")

            let payload = {}
            payload.drag_card_id = e.dataTransfer.getData("dragged_card_id")
            payload.drag_card_type = e.dataTransfer.getData("dragged_card_type")
            // payload.drop_card_id = this.el.id;
            // payload.drop_card_type = card_type

            this.pushEventTo(phx_target, "add-card-to-stall", payload);
        });
    }
}



// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket


import "alpinejs"

