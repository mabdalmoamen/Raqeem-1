<template>
    <div>
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <div class="card mb-4">
                    <form @submit.prevent="create">
                        <div
                            class="card-header py-3 d-flex flex-row align-items-center justify-content-between"
                        >

                            <h6 class="m-0 font-weight-bold text-primary">
                                {{ __("Insert Category Information") }}
                            </h6>
                            <button class="btn btn-primary" type="submit">
                                حفظ
                            </button>
                        </div>
                        <div class="card-body">
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span
                                        id="basic-addon1"
                                        class="input-group-text"
                                        >{{ __("Category Name ar") }}</span
                                    >
                                </div>
                                <input
                                    aria-describedby="basic-addon1"
                                    class="form-control"
                                    v-model="form.main_type_title_ar"
                                    type="text" required
                                />
                            </div>
                            <div class="input-group mb-3">
                                <div class="input-group-append">
                                    <span
                                        id="basic-addon2"
                                        class="input-group-text"
                                    >
                                        {{ __("Category Name En") }}</span
                                    >
                                </div>
                                <input
                                    aria-describedby="basic-addon2"
                                    class="form-control"
                                    v-model="form.main_type_title_en"
                                    type="text"
                                />
                            </div>
                            <div class="input-group mb-3">
                                <div class="input-group-append">
                                    <span
                                        id="basic-addon2"
                                        class="input-group-text"
                                    >
                                        {{ __("Select Printer") }}</span
                                    >
                                </div>
                                <select
                                    name="printer"
                                    id="printer"
                                    v-model="form.printer_name"
                                >
                                    <option disabled n-bind:key="undefined">
                                        Select printer
                                    </option>
                                    <option
                                        v-for="printer in printers"
                                        v-bind:key="printer"
                                    >
                                        {{ printer }}
                                    </option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import * as JSPM from "jsprintmanager";

export default {
    created() {
        if (!User.loggedIn()) {
            this.$router.push("/");
        }
    },
    data() {
        return {
            form: {
                main_type_title_ar: null,
                main_type_title_en: null,
                printer_name: "",
            },
            printers: [],
            errors: {},
            print2default: false,
        };
    },

    methods: {
        onInit() {
            var _this = this;
            JSPM.JSPrintManager.auto_reconnect = true;
            JSPM.JSPrintManager.start();
            JSPM.JSPrintManager.WS.onStatusChanged = function () {
                _this.getPrinters().then((p) => {
                    _this.printers = p;
                    _this.$nextTick();
                });
            };
        },
        getPrinters() {
            return new Promise((ok, err) => {
                let printers = [];
                if (
                    JSPM.JSPrintManager.websocket_status == JSPM.WSStatus.Open
                ) {
                    JSPM.JSPrintManager.getPrinters()
                        .then(function (myPrinters) {
                            printers = myPrinters;
                            console.log(printers);
                            ok(printers);
                        })
                        .catch((e) => err(e));
                } else {
                    console.warn("JSPM WS not open");
                    ok(printers);
                }
            });
        },
        create() {
            axios
                .post("/api/mainTypes", this.form)
                .then(() => {
                    this.$router.push({ name: "mainTypes" });
                    Notification.success();
                })
                .catch((error) => (this.errors = error.response.data.errors));
        },
    },
    mounted() {
        this.onInit();
    },
};
</script>
