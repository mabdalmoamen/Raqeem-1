<template>
    <div>
        <div v-if="user.create_customer" class="row justify-content-center">
            <div class="col-md-8">
                <div class="card mb-4">
                    <form class="user" @submit.prevent="create">
                        <div
                            class="card-header py-3 d-flex flex-row align-items-center justify-content-between"
                        >

                            <h6 class="m-0 font-weight-bold text-primary">
                                {{ __("Insert Customer Information") }}
                            </h6>
                            <button class="btn btn-primary" type="submit">
                                {{ __("Save") }}
                            </button>
                        </div>
                        <div class="card-body">
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        {{ __("Name") }}</span
                                    >
                                </div>
                                <input
                                    class="form-control"
                                    v-model="form.cust_name"
                                    type="text"
                                />
                                <div class="input-group-prepend">
                                    <span class="input-group-text">{{
                                        __("Address")
                                    }}</span>
                                </div>
                                <input
                                    class="form-control"
                                    v-model="form.cust_address"
                                    type="text"
                                />
                            </div>
                            <div class="input-group mb-3">
                                <div class="input-group-append">
                                    <span class="input-group-text">{{
                                        __("Mobile")
                                    }}</span>
                                </div>
                                <input
                                    class="form-control"
                                    v-model="form.cust_mobile"
                                    type="text"
                                />
                                <div class="input-group-append">
                                    <span class="input-group-text">{{
                                        __("Balance")
                                    }}</span>
                                </div>
                                <input
                                    class="form-control"
                                    readonly
                                    v-model="form.cust_balance"
                                    type="text"
                                />
                            </div>
                            <div class="input-group mb-3">
                                <div class="input-group-append">
                                    <span class="input-group-text">{{
                                        __("Discount Value")
                                    }}</span>
                                </div>
                                <input
                                    class="form-control d-none"
                                    :readonly="form.cust_discount_percent > 0"
                                    v-model="form.cust_discount_val"
                                    type="text"
                                />
                                <div class="input-group-append">
                                    <span class="input-group-text">{{
                                        __("Discount Percent")
                                    }}</span>
                                </div>
                                <input
                                    class="form-control"
                                    :readonly="form.cust_discount_val > 0"
                                    v-model="form.cust_discount_percent"
                                    type="text"
                                />
                            </div>
                            <div class="input-group mb-3">
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        {{ __("Customer Vat Number") }}</span
                                    >
                                </div>
                                <input
                                    class="form-control"
                                    v-model="form.cust_vat_num"
                                    type="text"
                                />
                            </div>

                            <div class="input-group mb-3">
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        {{ __("Customer Note") }}</span
                                    >
                                </div>
                                <input
                                    class="form-control"
                                    v-model="form.notes"
                                    type="text"
                                />
                            </div>

                            <div class="input-group mb-3">
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        {{ __("Customer identity") }}</span
                                    >
                                </div>
                                <input
                                    class="form-control"
                                    v-model="form.identity"
                                    type="text"
                                />
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <Security v-else></Security>
    </div>
</template>

<script>
import Security from "../spinner/security";
import Spinner from "../spinner/mixinsSpinner";

export default {
    components: { Security, Spinner },

    async created() {
        if (!User.loggedIn()) {
            this.$router.push("/");
        }
        await axios
            .get("/api/users/" + localStorage.getItem("user_id"))
            .then(({ data }) => (this.user = data))
            .catch((error) => console.log(error));
    },
    data() {
        return {
            user: {},
            form: {
                cust_name: null,
                cust_address: null,
                cust_discount_val: 0,
                cust_discount_percent: 0,
                cust_mobile: null,
                cust_balance: 0,
            },
            errors: {},
        };
    },

    methods: {
        create() {
            axios
                .post("/api/customers", this.form)
                .then(() => {
                    this.$router.push({ name: "customers" });
                    Notification.success();
                })
                .catch((error) => {
                    this.errors = error.response.data.errors;
                })
                .then((error) => {
                    if (this.errors.cust_name)
                        Notification.customMsg(
                            "error",
                            "topRight",
                            this.errors.cust_name[0]
                        );
                    if (this.errors.cust_mobile)
                        Notification.customMsg(
                            "error",
                            "topRight",
                            this.errors.cust_mobile[0]
                        );
                });
        },
    },
};
</script>
