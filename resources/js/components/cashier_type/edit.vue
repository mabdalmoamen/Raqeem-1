<template>
    <div>
        <div v-if="user.edit_type" class="row justify-content-center">
            <div class="col-md-11">
                <div class="card shadow-sm mt-3">
                    <div class="card-body p-0">
                        <form
                            class="types"
                            dir="rtl"
                            enctype="multipart/form-data"
                        >
                            <div class="card-header">
                                <h6
                                    class="m-0 font-weight-bold text-primary d-inline float-right"
                                >
                                    تعديل بيانات الصنف
                                </h6>
                                <a
                                    @click="update"
                                    class="btn btn-primary float-left"
                                >
                                    حفظ
                                </a>
                            </div>
                            <div class="card-body">
                                <div class="input-group mb-3">
                                    <img
                                        v-if="newphoto"
                                        :src="type.newphoto"
                                        class="card-img-top w-25 h-25 float-left ml-auto"
                                    />
                                    <img
                                        v-else=""
                                        :src="type.type_icon"
                                        class="card-img-top w-25 h-25 float-left ml-auto"
                                    />
                                    <input
                                        id="customFile"
                                        class="custom-file-input"
                                        type="file"
                                        @change="onFileSelected"
                                    />
                                    <span
                                        class="custom-file-label input-group-text w-100"
                                        for="customFile"
                                        style="width: 80px; text-align: center"
                                    ></span>
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"
                                            >اسم الصنف عربي</span
                                        >
                                    </div>
                                    <input
                                        onclick="this.select();"
                                        v-model="type.type_name_ar"
                                        aria-describedby="basic-addon1"
                                        aria-label="اسم الصنف عربي"
                                        class="form-control"
                                        placeholder="اسم الصنف عربي"
                                        type="text"
                                        required
                                    />
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"
                                            >اسم الصنف انجليزي</span
                                        >
                                    </div>
                                    <input
                                        onclick="this.select();"
                                        v-model="type.type_name_en"
                                        aria-describedby="basic-addon1"
                                        aria-label="اسم الصنف انجليزي"
                                        class="form-control"
                                        placeholder="اسم الصنف انجليزي"
                                        type="text"
                                    />
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                سعر الشراء</span
                                            >
                                        </div>
                                        <input
                                            onclick="this.select();"
                                            v-model="type.type_purchases_price"
                                            aria-describedby="basic-addon1"
                                            aria-label="سعر الشراء"
                                            class="form-control"
                                            placeholder="سعر الشراء"
                                            type="number"
                                            min="0"
                                            step="0.1"
                                        />
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"
                                                >سعر البيع</span
                                            >
                                        </div>
                                        <input
                                            onclick="this.select();"
                                            v-model="type.type_sill_price"
                                            aria-describedby="basic-addon1"
                                            aria-label="سعر البيع"
                                            class="form-control"
                                            placeholder="سعر البيع"
                                            type="number"
                                            min="0"
                                            step="0.1"
                                            required
                                        />
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                أقل سعر البيع</span
                                            >
                                        </div>
                                        <input
                                            onclick="this.select();"
                                            v-model="type.minimum_sill_price"
                                            aria-describedby="basic-addon1"
                                            aria-label="أقل سعر البيع "
                                            class="form-control"
                                            placeholder="أقل سعر البيع"
                                            type="number"
                                            min="0"
                                            step="0.1"
                                        />
                                    </div>
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            التصنيف</span
                                        >
                                    </div>
                                    <select
                                        v-model="type.main_type"
                                        class="form-control w-25"
                                    >
                                        <option
                                            v-for="(cat, index) in categories"
                                            :key="index"
                                            :value="cat.main_type_id"
                                        >
                                            {{ cat.main_type_title_ar }}
                                        </option>
                                    </select>
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            تاريخ الصلاحية
                                        </span>
                                    </div>
                                    <input
                                        onclick="this.select();"
                                        v-model="type.type_exp_date"
                                        aria-describedby="basic-addon1"
                                        aria-label="تاريخ الصلاحية"
                                        class="form-control"
                                        placeholder="تاريخ الصلاحية"
                                        type="date"
                                    />
                                </div>

                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            الباركود الدولي
                                        </span>
                                        <button
                                            type="button"
                                            class="btn"
                                            @click="generateBarcode"
                                        >
                                            <i class="fa fa-sync"></i>
                                        </button>
                                    </div>
                                    <input
                                        v-model="type.type_barcode"
                                        aria-describedby="basic-addon1"
                                        aria-label="  الباركود الدولي"
                                        class="form-control"
                                        placeholder="  الباركود الدولي"
                                        type="text"
                                        onclick="event.preventDefault();this.select();"
                                        onchange="event.preventDefault();"
                                        onkeyup="event.preventDefault();"
                                    />
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"
                                            >كود مختصر</span
                                        >
                                    </div>
                                    <input
                                        onclick="this.select();"
                                        v-model="type.type_code"
                                        aria-describedby="basic-addon1"
                                        aria-label="كود مختصر"
                                        class="form-control"
                                        placeholder=" كود مختصر"
                                        type="text"
                                    />
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend d-none">
                                        <span class="input-group-text"
                                            >نسبة الخصم</span
                                        >
                                    </div>
                                    <input
                                        onclick="this.select();"
                                        v-model="type.type_discount_percent"
                                        aria-describedby="basic-addon1"
                                        aria-label="نسبة الخصم"
                                        class="form-control d-none"
                                        placeholder=" نسبة الخصم"
                                        type="text"
                                        :readonly="type.type_sill_price <= 0"
                                    />
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"
                                            >قيمة الخصم</span
                                        >
                                    </div>
                                    <input
                                        onclick="this.select();"
                                        v-model="type.type_discount_value"
                                        aria-describedby="basic-addon1"
                                        aria-label="قيمة الخصم"
                                        class="form-control"
                                        placeholder="قيمة الخصم"
                                        type="number"
                                        min="0"
                                        step="0.1"
                                    />
                                </div>
                                <div
                                    class="input-group mb-3"
                                    v-show="!$root.$data.codies.fixed_vat"
                                >
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"
                                            >نسبة الضريبة</span
                                        >
                                    </div>
                                    <input
                                        onclick="this.select();"
                                        v-model="type.type_vat_percent"
                                        aria-describedby="basic-addon1"
                                        aria-label="نسبة الضريبة "
                                        class="form-control"
                                        placeholder="نسبة الضريبة"
                                        type="number"
                                        min="0"
                                        step="0.1"
                                        :readonly="type.type_sill_price <= 0"
                                    />
                                </div>
                                <div class="card">
                                    <div
                                        class="card-header d-flex flex-row align-items-center justify-content-between"
                                    >
                                        <div class="input-group-prepend">
                                            <a
                                                class="btn btn-sm btn-success"
                                                @click="addUnit()"
                                            >
                                                اضافة وحدة الصنف
                                                <i class="fa fa-plus"></i>
                                            </a>
                                        </div>

                                        <div class="input-group-prepend">
                                            <span
                                                class="input-group-text btn btn-sm"
                                                for="selectUnit"
                                            >
                                                وحدة البيع
                                            </span>
                                            <select
                                                required
                                                class="form-control"
                                                id="selectUnit"
                                                v-model="type.sell_unit"
                                            >
                                                <option
                                                    :key="index"
                                                    v-for="(
                                                        selected, index
                                                    ) in type.units"
                                                    :value="selected"
                                                    :selcted="
                                                        type.sell_unit ===
                                                        selected
                                                    "
                                                >
                                                    {{
                                                        selected.unit
                                                            .unit_ar_name
                                                    }}
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="card-body w-100">
                                        <div class="row">
                                            <div class="col-6">
                                                <table
                                                    v-if="type.units"
                                                    class="table-bordered text-center"
                                                >
                                                    <thead>
                                                        <tr>
                                                            <th>الوحدة</th>
                                                            <th>عدد الوحدات</th>
                                                            <th>السعر</th>
                                                            <th>فرق السعر</th>
                                                            <th>باركود</th>
                                                            <th>اعدادات</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr
                                                            class="text-center"
                                                            v-for="(
                                                                selected, index
                                                            ) in type.units"
                                                            :key="index"
                                                        >
                                                            <td>
                                                                {{
                                                                    selected
                                                                        .unit
                                                                        .unit_ar_name
                                                                }}
                                                            </td>
                                                            <td>
                                                                {{
                                                                    selected.no_of_unit
                                                                }}
                                                            </td>

                                                            <td>
                                                                <input
                                                                    class="form-control"
                                                                    type="number"
                                                                    step="0.1"
                                                                    min="0"
                                                                    required
                                                                    v-model="
                                                                        selected.price
                                                                    "
                                                                />
                                                            </td>
                                                            <td>
                                                                <input
                                                                    class="form-control"
                                                                    type="number"
                                                                    step="0.1"
                                                                    min="0"
                                                                    required
                                                                    v-model="
                                                                        selected.deff_price
                                                                    "
                                                                    id=""
                                                                />
                                                            </td>
                                                            <td>
                                                                {{
                                                                    selected.barcode
                                                                }}
                                                            </td>
                                                            <td>
                                                                <i
                                                                    @click="
                                                                        deleteUnit(
                                                                            selected.type_unit_id
                                                                        )
                                                                    "
                                                                    class="pointer btn-sm btn-danger fa fa-times"
                                                                ></i>

                                                                <i
                                                                    @click="
                                                                        UpdateUnit(
                                                                            selected
                                                                        )
                                                                    "
                                                                    class="pointer btn-sm btn-success fa fa-save"
                                                                ></i>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="col-6">
                                                <table
                                                    class="table-bordered text-center"
                                                    v-show="
                                                        selected_units.length >
                                                        0
                                                    "
                                                >
                                                    <thead>
                                                        <tr>
                                                            <th>الوحدة</th>
                                                            <th>عدد الوحدات</th>
                                                            <th>السعر</th>
                                                            <th>فرق السعر</th>
                                                            <th>باركود</th>
                                                            <th>X</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr
                                                            class="text-center"
                                                            v-for="(
                                                                selected, index
                                                            ) in selected_units"
                                                            :key="index"
                                                        >
                                                            <td>
                                                                <select
                                                                    class="form-control"
                                                                    v-model="
                                                                        selected.unit_id
                                                                    "
                                                                    @change="
                                                                        onChangeCountCalcPrice(
                                                                            selected
                                                                        )
                                                                    "
                                                                >
                                                                    <option
                                                                        v-for="(
                                                                            unit,
                                                                            i
                                                                        ) in units"
                                                                        :value="
                                                                            unit
                                                                        "
                                                                    >
                                                                        {{
                                                                            unit.unit_ar_name
                                                                        }}
                                                                    </option>
                                                                </select>
                                                            </td>
                                                            <td>
                                                                <input
                                                                    onclick="this.select();"
                                                                    class="form-control"
                                                                    v-model="
                                                                        selected.no_of_unit
                                                                    "
                                                                    @keyup="
                                                                        onChangeCountCalcPrice(
                                                                            selected
                                                                        )
                                                                    "
                                                                    type="number"
                                                                />
                                                            </td>
                                                            <td>
                                                                <input
                                                                    onclick="this.select();"
                                                                    class="form-control"
                                                                    v-model="
                                                                        selected.price
                                                                    "
                                                                    type="number"
                                                                    min="0"
                                                                    step="0.1"
                                                                />
                                                            </td>
                                                            <td>
                                                                <input
                                                                    onclick="this.select();"
                                                                    class="form-control"
                                                                    v-model="
                                                                        selected.deff_price
                                                                    "
                                                                    @keyup="
                                                                        onChangeCountCalcPrice(
                                                                            selected
                                                                        )
                                                                    "
                                                                />
                                                            </td>
                                                            <td>
                                                                <input
                                                                    onclick="this.select();"
                                                                    class="form-control"
                                                                    v-model="
                                                                        selected.barcode
                                                                    "
                                                                />
                                                            </td>
                                                            <td
                                                                @click="
                                                                    removeUnit(
                                                                        selected,
                                                                        index
                                                                    )
                                                                "
                                                            >
                                                                <i
                                                                    class="pointer btn-sm btn-danger fa fa-times"
                                                                ></i>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"
                                            >مكان الصنف</span
                                        >
                                    </div>
                                    <input
                                        onclick="this.select();"
                                        v-model="type.type_location"
                                        aria-describedby="basic-addon1"
                                        aria-label="مكان الصنف"
                                        class="form-control"
                                        placeholder="مكان الصنف"
                                        type="text"
                                    />
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"
                                            >ملاحظــــات الصنف</span
                                        >
                                    </div>
                                    <input
                                        onclick="this.select();"
                                        v-model="type.type_note"
                                        aria-describedby="basic-addon1"
                                        aria-label="ملاحظــــات الصنف"
                                        class="form-control"
                                        placeholder="ملاحظــــات الصنف"
                                        type="text"
                                    />
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div v-else><Security></Security></div>
    </div>
</template>

<script type="text/javascript">
import Security from "../spinner/security";
import Spinner from "../spinner/mixinsSpinner";

export default {
    components: { Security, Spinner },

    async created() {
        if (!User.loggedIn()) {
            await this.$router.push("/");
        }
        await axios
            .get("/api/users/" + localStorage.getItem("user_id"))
            .then(({ data }) => (this.user = data))
            .catch((error) => console.log(error));
        let id = this.$route.params.id;
        await axios
            .get("/api/types/" + id)
            .then(({ data }) => {
                console.log(data);
                this.type = data;
            })
            .catch((error) => console.log(error));
        await this.allMainType();
        await this.allUnits();
        await axios
            .get("/api/user/roles/" + localStorage.getItem("user_id") + "/" + 1)
            .then(({ data }) => {
                this.haveRole = data;
            })
            .catch((error) => console.log(error));
    },

    data() {
        return {
            haveRole: false,
            user: {},
            categories: [],

            type: {},
            newphoto: null,
            type_units: {
                unit_id: "",
                no_of_unit: 1,
                deff_price: 0.0,
                price: 0.0,
                barcode: "",
            },
            selected_units: [],
            units: [],
            errors: {},
        };
    },

    methods: {
        generateBarcode() {
            this.type.type_barcode = "";

            if (this.type.type_barcode > 10000) {
                var val1 = Math.floor(
                    this.type.type_barcode + Math.random() * 99
                );
                this.type.type_barcode = val1;
            } else {
                var val1 = Math.floor(100 + Math.random() * 99);
                this.type.type_barcode = this.type.type_barcode + 1 + "" + val1;
            }
        },

        onFileSelected(event) {
            let file = event.target.files[0];
            if (file.size > 1048770) {
                Notification.image_validation();
            } else {
                let reader = new FileReader();
                reader.onload = (event) => {
                    this.type.newphoto = event.target.result;
                    this.newphoto = event.target.result;
                };
                reader.readAsDataURL(file);
            }
        },
        allMainType() {
            axios
                .get("/api/mainTypes")
                .then(({ data }) => {
                    this.categories = data;
                })
                .catch((error) => console.log(error));
        },
        allUnits() {
            axios
                .get("/api/units")
                .then(({ data }) => {
                    this.units = data;
                })
                .catch((error) => console.log(error));
        },
        calcVatVal() {
            this.type.type_discount_value = 0.0;
            if (
                this.type.type_sill_price > 0 &&
                this.type.type_vat_percent > 0
            ) {
                if (this.type.type_has_vat) {
                    let price =
                        this.type.type_sill_price /
                        (1 + this.type.type_vat_percent / 100.0);
                    this.type.type_vat_value =
                        ((price - this.type.type_discount_value) *
                            this.type.type_vat_percent) /
                        100.0;
                } else {
                    this.type.type_vat_value =
                        ((this.type.type_sill_price -
                            this.type.type_discount_value) *
                            this.type.type_vat_percent) /
                        100.0;
                }
            }
        },
        calcVatPercent() {
            this.type.type_vat_percent = 0;
            if (this.type.type_sill_price > 0 && this.type.type_vat_value > 0) {
                if (this.type.type_has_vat) {
                    let price =
                        this.type.type_sill_price /
                        (1 + this.type.type_vat_percent / 100.0);
                    this.type.type_vat_percent =
                        (this.type.type_vat_value /
                            (price - this.type.type_discount_value)) *
                        100.0;
                } else {
                    this.type.type_vat_percent =
                        (this.type.type_vat_value /
                            (this.type.type_sill_price -
                                this.type.type_discount_value)) *
                        100.0;
                }
            }
        },
        calcDiscountVal() {
            this.type.type_discount_value = 0;
            if (
                this.type.type_sill_price > 0 &&
                this.type.type_discount_percent > 0
            ) {
                this.type.type_discount_value =
                    (this.type.type_sill_price *
                        this.type.type_discount_percent) /
                    100.0;
            }
        },
        calcDiscountPercent() {
            this.type.type_discount_percent = 0;
            if (
                this.type.type_sill_price > 0 &&
                this.type.type_discount_value > 0
            ) {
                this.type.type_discount_percent =
                    (this.type.type_discount_value /
                        this.type.type_sill_price) *
                    100.0;
            }
        },
        addUnit() {
            let TypeUnits = JSON.parse(JSON.stringify(this.type_units));
            this.selected_units.push(TypeUnits);
        },
        removeUnit(selected, index) {
            selected.no_of_unit = 1;
            selected.price = 0;
            this.$delete(this.selected_units, index);
        },
        onChangeCountCalcPrice(selected) {
            selected.price = 0;
            selected.price =
                this.type.type_sill_price / selected.no_of_unit +
                Number(selected.deff_price);
        },
        update() {

            if (this.type.sell_unit == null) {
                Notification.customMsg(
                    "error",
                    "topRight",
                    "يجب اختيار وحدة بيع "
                );
                return;
            }
            this.updateWithValidData();
        },
        updateWithValidData() {
            if (this.selected_units.length > 0) {
                this.type.type_unit = this.selected_units;
            }
            let id = this.$route.params.id;
            axios
                .patch("/api/cashier/types/" + id, this.type)
                .then(() => {
                    axios.get("/api/types/" + id).then(({ data }) => {
                        this.type = data;
                    });
                    this.type.type_unit = [];
                    this.selected_units = [];
                    Notification.success();
                })
                .catch((error) => {
                    this.errors = error.response.data.errors;
                })
                .then((e) => {
                    if (this.errors.type_name_ar)
                        Notification.customMsg(
                            "error",
                            "topRight",
                            this.errors.type_name_ar[0]
                        );
                    if (this.errors.type_sill_price)
                        Notification.customMsg(
                            "error",
                            "topRight",
                            this.errors.type_sill_price[0]
                        );
                    if (this.errors.type_barcode)
                        Notification.customMsg(
                            "error",
                            "topRight",
                            this.errors.type_barcode[0]
                        );
                    if (this.errors.sell_unit)
                        Notification.customMsg(
                            "error",
                            "topRight",
                            this.errors.sell_unit[0]
                        );
                });
        },
        UpdateUnit(unit) {
            axios
                .patch("/api/units/" + unit.type_unit_id, unit)
                .then(() => Notification.success());
        },
        deleteUnit(id) {
            if (confirm("هل تريد الحذف؟لايمكن الاستعاده مره اخرى.")) {
                if (this.type.units.length > 1) {
                    if (this.type.sell_unit.type_unit_id != id) {
                        axios
                            .delete("/api/units/" + id)
                            .then(() => {
                                this.type.units = this.type.units.filter(
                                    (type) => {
                                        return type.type_unit_id != id;
                                    }
                                );
                                Notification.successMsg("تم الحذف بنجاح");
                            })
                            .catch(() => {
                                Notification.errorMsg("لايمكن حذف العملية");
                            });
                    } else {
                        Notification.errorMsg(
                            "لايمكن حذف العملية الإفتراضية للصنف يجب تغير العملية أولا"
                        );
                    }
                } else {
                    Notification.errorMsg(
                        "يجب أن يكون هناك عملية واحده على الأقل"
                    );
                }
            }
        },
    },
};
</script>

<style type="text/css"></style>
