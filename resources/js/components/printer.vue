<template>
    <div v-if="bill && mixins">
        <a
            id="btn"
            class="btn btn-info text-light d-none"
            data-target="#printModal"
            data-toggle="modal"
            ><i class="fas fa-ellipsis-v"></i
        ></a>
        <div
            id="printModal"
            aria-hidden="true"
            aria-labelledby="printModal"
            class="modal fade"
            role="dialog"
            tabindex="-1"
        >
            <div
                class="modal-dialog modal-dialog-centered modal-dialog-scrollable"
                role="document"
            >
                <div class="modal-content m-auto">
                    <div class="modal-header">
                        <button
                            aria-label="Close"
                            class="close"
                            data-dismiss="modal"
                            type="button"
                        >
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div id="printMe" class="modal-body">
                        <div id="invoice-POS" class="pos-section">
                            <div id="top" style="text-align: center">
                                <div class="logo text-center">
                                    <img
                                        :src="mixins.mixins_logo"
                                        :style="{
                                            width: mixins.logo_width + 'px',
                                            height: mixins.logo_height + 'px',
                                            borderRadius: '50%',
                                        }"
                                    />
                                </div>
                                <div class="info">
                                    <span class="m-0">
                                        {{ mixins.mixins_name }}
                                    </span>
                                </div>
                                <div class="info">
                                    <span class="m-0">
                                        {{ mixins.contruct_no }}
                                    </span>
                                </div>
                                <div class="info">
                                    <span class="m-0">
                                        {{ mixins.mixins_adress }}
                                    </span>
                                </div>
                                <div class="info">
                                    <span class="m-0">
                                        {{ mixins.mixins_mobile }}
                                    </span>
                                </div>
                                <!--End Info-->
                                <div
                                    v-if="bill.customer != null"
                                    class="text-center d-none"
                                >
                                    <small
                                        v-if="
                                            bill.customer.cust_vat_num &&
                                            mixins.mixins_vat_val > 0
                                        "
                                    >
                                        ???????????? ????????????
                                    </small>
                                    <small v-else="mixins.mixins_vat_val > 0"
                                        >???????????? ???????????? ??????????</small
                                    >
                                </div>
                                <div v-else class="text-center d-none">
                                    <small
                                        v-if="
                                            mixins.mixins_vat_val > 0 &&
                                            mixins.contruct_no
                                        "
                                    >
                                        ???????????? ???????????? ??????????</small
                                    >
                                </div>
                            </div>
                            <!--End InvoiceTop-->
                            <div id="bot">
                                <div id="table">
                                    <table
                                        id="resultTable"
                                        class="text-center w-100"
                                    >
                                        <tr>
                                            <td colspan="3" class="no-border">
                                                ?????? ????????????????
                                            </td>
                                            <td colspan="3" class="no-border">
                                                {{ bill.bill_no }}
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" class="no-border">
                                                ?????????? ????????????????
                                            </td>
                                            <td colspan="3" class="no-border">
                                                {{
                                                    moment(
                                                        bill.bill_date
                                                    ).format("DD-MM-YYYY")
                                                }}
                                            </td>
                                        </tr>
                                        <tr v-if="bill.sale">
                                            <td colspan="3" class="no-border">
                                                ?????? ??????????
                                            </td>
                                            <td colspan="3" class="no-border">
                                                {{ bill.sale.sill_type_name }}
                                            </td>
                                        </tr>
                                        <tr>
                                            <td
                                                colspan="3"
                                                class="no-border"
                                                v-if="bill.user != null"
                                            >
                                                ???????????? ????????????
                                            </td>
                                            <td
                                                colspan="3"
                                                class="no-border"
                                                v-if="bill.user != null"
                                            >
                                                {{ bill.user.name }}
                                            </td>
                                        </tr>
                                        <tr>
                                            <td
                                                colspan="3"
                                                class="no-border"
                                                v-if="bill.pay_methods != null"
                                            >
                                                ?????????? ??????????
                                            </td>
                                            <td
                                                colspan="3"
                                                class="no-border"
                                                v-if="bill.pay_methods != null"
                                            >
                                                {{
                                                    bill.pay_methods
                                                        .pay_method_name
                                                }}
                                            </td>
                                        </tr>
                                        <tr
                                            v-if="
                                                bill.table != null &&
                                                bill.table.table_no
                                            "
                                        >
                                            <td colspan="3" class="no-border">
                                                ?????? ??????????????
                                            </td>
                                            <td colspan="3" class="no-border">
                                                {{ bill.table.table_no }}
                                            </td>
                                        </tr>
                                        <tr
                                            v-if="
                                                bill.customer &&
                                                bill.customer.cust_name
                                            "
                                        >
                                            <td colspan="3" class="no-border">
                                                ?????? ????????????
                                            </td>
                                            <td colspan="3" class="no-border">
                                                {{ bill.customer.cust_name }}
                                            </td>
                                        </tr>
                                        <tr
                                            v-if="
                                                bill.customer &&
                                                bill.customer.cust_mobile
                                            "
                                        >
                                            <td colspan="3" class="no-border">
                                                ???????? ????????????
                                            </td>
                                            <td colspan="3" class="no-border">
                                                {{ bill.customer.cust_mobile }}
                                            </td>
                                        </tr>

                                        <tr
                                            v-if="
                                                bill.customer &&
                                                bill.customer.cust_address
                                            "
                                        >
                                            <td colspan="3" class="no-border">
                                                ?????????? ????????????
                                            </td>

                                            <td colspan="3" class="no-border">
                                                {{ bill.customer.cust_address }}
                                            </td>
                                        </tr>
                                        <tr
                                            v-if="
                                                bill.customer &&
                                                bill.customer.cust_vat_num
                                            "
                                        >
                                            <td colspan="3" class="no-border">
                                                ?????????? ?????????????? ????????????
                                            </td>
                                            <td colspan="3" class="no-border">
                                                {{ bill.customer.cust_vat_num }}
                                            </td>
                                        </tr>
                                        <tr
                                            v-if="
                                                bill.customer &&
                                                bill.customer.cust_balance
                                            "
                                        >
                                            <td colspan="3" class="no-border">
                                                ???????? ????????????
                                            </td>

                                            <td colspan="3" class="no-border">
                                                {{ bill.customer.cust_balance }}
                                            </td>
                                        </tr>
                                        <td colspan="6">
                                            <hr class="hr-line" />
                                        </td>

                                        <tr class="text-center">
                                            <th>?????? ??????????</th>
                                            <th>??????????</th>
                                            <th>
                                                {{
                                                    mixins.codies_type
                                                        ? "????????????"
                                                        : "??????????????"
                                                }}
                                            </th>
                                            <th>??????????</th>
                                            <th>??????????</th>

                                            <th>????????????????</th>
                                        </tr>
                                        <tr
                                            v-for="(
                                                type, index
                                            ) in bill.bill_type"
                                            :key="index"
                                            :class="
                                                type.returned
                                                    ? 'text-decoration-line-through '
                                                    : ''
                                            "
                                        >
                                            <td>
                                                {{ type.type.type_name_ar }}
                                                <small
                                                    class="d-block text-wrap"
                                                    >{{ type.type_note }}</small
                                                >
                                            </td>
                                            <td class="text-center">
                                                {{ type.type_count }}
                                            </td>
                                            <td class="text-center">
                                                {{
                                                    type.units
                                                        ? type.units.unit
                                                              .unit_ar_name
                                                        : "-"
                                                }}
                                            </td>

                                            <td class="text-center">
                                                {{ type.type_price }}
                                            </td>
                                            <td class="text-center">
                                                {{ type.type_discount }}
                                            </td>
                                            <td class="text-center">
                                                {{ type.type_total_price }}
                                            </td>
                                        </tr>
                                        <td colspan="6">
                                            <hr class="hr-line" />
                                        </td>

                                        <tr>
                                            <td colspan="3" class="no-border">
                                                {{
                                                    bill.sum_after_discount >
                                                        0 &&
                                                    bill.sum_after_discount !=
                                                        bill.bill_sum
                                                        ? " ?????????????? ????????????:"
                                                        : " ??????????????:"
                                                }}
                                            </td>
                                            <td colspan="3" class="no-border">
                                                {{ bill.bill_sum }}
                                            </td>
                                        </tr>
                                        <tr
                                            v-if="
                                                bill.bill_discount > 0 &&
                                                bill.offer_discount === 0
                                            "
                                        >
                                            <td colspan="3" class="no-border">
                                                ?????????? ({{
                                                    bill.bill_discount
                                                }}%):
                                            </td>

                                            <td colspan="3" class="no-border">
                                                {{ bill.bill_discount_percent }}
                                            </td>
                                        </tr>
                                        <tr v-if="bill.sale_discount > 0">
                                            <td colspan="3" class="no-border">
                                                ?????? ????????????????:
                                            </td>
                                            <td colspan="3" class="no-border">
                                                {{ bill.sale_discount }}
                                            </td>
                                        </tr>
                                        <tr v-if="bill.offer_discount > 0">
                                            <td colspan="3" class="no-border">
                                                ?????? ??????
                                                {{ mixins.offer_percenet }} %
                                            </td>

                                            <td colspan="3" class="no-border">
                                                {{ bill.offer_discount }}
                                            </td>
                                        </tr>
                                        <tr v-if="bill.bill_extra > 0">
                                            <td colspan="3" class="no-border">
                                                ??????????????:
                                            </td>
                                            <td colspan="3" class="no-border">
                                                {{ bill.bill_extra }}
                                            </td>
                                        </tr>
                                        <tr
                                            v-if="
                                                bill.sum_after_discount > 0 &&
                                                bill.sum_after_discount !=
                                                    bill.bill_sum
                                            "
                                        >
                                            <td colspan="3" class="no-border">
                                                ??????????????:
                                            </td>
                                            <td colspan="3" class="no-border">
                                                {{ bill.sum_after_discount }}
                                            </td>
                                        </tr>
                                        <tr v-if="bill.bill_vat_val > 0">
                                            <td colspan="3" class="no-border">
                                                ?????????? ???????????? ?????????????? ({{
                                                    bill.vat
                                                }}%):
                                            </td>
                                            <td colspan="3" class="no-border">
                                                {{ bill.bill_vat_val }}
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" class="no-border">
                                                ????????????????:
                                            </td>
                                            <td colspan="3" class="no-border">
                                                {{ bill.bill_total }}
                                                <small style="display: block">
                                                    {{ bill.billTotal }}</small
                                                >
                                            </td>
                                        </tr>
                                        <tr
                                            v-if="
                                                bill.bill_paid_val !=
                                                bill.bill_total
                                            "
                                        >
                                            <td colspan="3" class="no-border">
                                                ??????????????:
                                            </td>
                                            <td colspan="3" class="no-border">
                                                {{ bill.bill_paid_val }}
                                            </td>
                                        </tr>
                                        <tr v-if="bill.bill_remain_val != 0">
                                            <td colspan="3" class="no-border">
                                                ????????????:
                                            </td>
                                            <td colspan="3" class="no-border">
                                                {{ bill.bill_remain_val }}
                                            </td>
                                        </tr>
                                        <tr v-if="bill.return_sum > 0">
                                            <td colspan="3" class="no-border">
                                                ?????????? ??????????????????:
                                            </td>
                                            <td colspan="3" class="no-border">
                                                {{ bill.return_sum }}
                                            </td>
                                        </tr>
                                        <tr v-if="bill.return_vat > 0">
                                            <td colspan="3" class="no-border">
                                                ?????????? ???????????? ??????????????
                                                ??????????????????({{
                                                    mixins.mixins_vat_val
                                                }}%):
                                            </td>
                                            <td colspan="3" class="no-border">
                                                {{ bill.return_vat }}
                                            </td>
                                        </tr>
                                        <tr v-if="bill.total_returned > 0">
                                            <td colspan="3" class="no-border">
                                                ???????????? ??????????????????:
                                            </td>
                                            <td colspan="3" class="no-border">
                                                {{ bill.total_returned }}
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <!--End Table-->
                                <div v-if="mixins.mixins_note">
                                    <ul class="navbar-nav row text-center">
                                        <li
                                            class="col-12"
                                            v-for="(
                                                note, index
                                            ) in mixins.mixins_note.split(',')"
                                            :key="index"
                                        >
                                            {{ note }}
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div
                                v-if="
                                    mixins.mixins_name != null &&
                                    !mixins.mixins_name.isEmpty &&
                                    mixins.contruct_no != null &&
                                    mixins.country === 2
                                "
                                class="text-center"
                            >
                                <img :src="qr" height="120" />
                            </div>
                            <!--End InvoiceBot-->
                            <div
                                v-if="bill.bill_notes"
                                class="footer text-center text-wrap"
                            >
                                {{ bill.bill_notes }}
                            </div>
                            <div
                                class="footer text-center"
                                style="
                                    font-size: 8px;
                                    font-weight: bolder;
                                    margin-top: 3px;
                                "
                            >
                                ?????????? ???????????? ????????????????
                                <i class="fa fa-phone"></i>
                                01002208627 -
                                <i class="fa fa-phone"></i> 01009199086 .
                            </div>
                        </div>
                        <!--End Invoice-->
                    </div>
                    <div class="modal-footer text-center">
                        <button
                            id="print"
                            class="btn btn-secondary"
                            data-dismiss="modal"
                            type="button"
                        >
                            ??????????
                        </button>
                        <button
                            id="printer"
                            class="btn btn-success d-none"
                            @click="print()"
                        >
                            ??????????
                        </button>
                        <button class="btn btn-success" @click="printOne()">
                            ??????????
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { Invoice } from "@axenda/zatca";
import moment from "moment";
import Cookie from "../Helpers/Cookie";

export default {
    props: ["bill", "qr"],

    async created() {
        if (!User.loggedIn()) {
            this.$router.push("/");
        }
        await this.getMixins();
    },
    data() {
        return {
            isDone: false,
            mixins: {},
            moment: moment,
            isclicked: false,
            mydata: [],
            billTotal: "",
        };
    },
    methods: {
        async getMixins() {
            await axios
                .get("/api/mixins/1")
                .then(({ data }) => {
                    this.mixins = data;
                })
                .catch((error) => console.log(error));
        },

        async print() {
            for (var count = 0; count < this.mixins.printer_count; count++) {
                this.$htmlToPaper("printMe");
            }
        },
        printOne() {
            this.$htmlToPaper("printMe");
        },
    },
};
</script>

<style scoped></style>
