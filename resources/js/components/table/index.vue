<template>
    <div>
        <div class="row">
            <!-- Datatables -->
            <div v-if="!loading" class="col-lg-12">
                <div class="card mb-4">
                    <div
                        class="card-header d-flex flex-row align-items-center justify-content-between"
                    >
                        <h6 class="m-0 font-weight-bold text-primary">
                            كل الطاولاتے
                        </h6>
                        <router-link
                            class="m-0 font-weight-bold text-primary"
                            to="/create/table"
                            >إضافة</router-link
                        >
                        <button
                            class="btn btn-primary"
                            onclick="download('xlsx');"
                            type="submit"
                        >
                            <i class="fa fa-file-excel"></i>
                        </button>

                        <h6
                            class="m-0 font-weight-bold text-primary float-left"
                        >
                            <div id="search">
                                <input
                                    id="filter"
                                    class="form-control-sm"
                                    name="filter"
                                    type="text"
                                    value=""
                                />
                            </div>
                        </h6>
                    </div>
                    <div class="w-100 dragscroll table-wrapper">
                        <div id="pagewrap" class="row">
                            <div id="body" class="col-sm-12">
                                <table
                                    v-if="tables.length > 0"
                                    id="resultTable"
                                    class="text-center table-bordered"
                                >
                                    <thead>
                                        <tr>
                                            <th
                                                class="col-header"
                                                style="width: 15%"
                                            >
                                                إعدادات
                                            </th>

                                            <th
                                                class="col-header"
                                                style="width: 15%"
                                            >
                                                رقم الطاولة
                                            </th>
                                            <th
                                                class="col-header"
                                                style="width: 15%"
                                            >
                                                الغرفة
                                            </th>
                                            <th
                                                class="col-header"
                                                style="width: 15%"
                                            >
                                                قيمة الحجز
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr
                                            v-for="(table, index) in tables"
                                            :key="index"
                                            class="ErrorRow"
                                        >
                                            <td>
                                                <router-link
                                                    :to="{
                                                        name: 'edit-table',
                                                        params: {
                                                            id: table.id,
                                                        },
                                                    }"
                                                    class="btn btn-sm btn-primary"
                                                    ><i class="fa fa-edit"></i>
                                                </router-link>
                                                <a
                                                    class="btn btn-sm btn-danger"
                                                    @click="
                                                        deleteAction(table.id)
                                                    "
                                                    ><i class="fa fa-trash"></i
                                                ></a>
                                            </td>
                                            <td>{{ table.table_no }}</td>
                                            <td>{{ table.room }}</td>
                                            <td>{{ table.mini_charge }}</td>
                                        </tr>
                                    </tbody>
                                    <tfoot></tfoot>
                                </table>
                                <p v-else class="text-center">
                                    {{ __("No Data Yet") }}
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- DataTable with Hover -->

            <Spinner v-else :title="title"> </Spinner>
        </div>
    </div>
</template>

<script>
import Spinner from "../spinner/mixinsSpinner.vue";
export default {
    components: { Spinner },
    async created() {
        if (!User.loggedIn()) {
            await this.$router.push("/");
        }
        this.allTables();
    },
    data() {
        return {
            title: "Tables",
            tables: [],
            searchTerm: "",
            loading: true,
        };
    },
    computed: {
        filterSearch() {
            return this.tables.filter((table) => {
                return table.table_no.match(this.searchTerm);
            });
        },
    },
    methods: {
        allTables() {
            axios
                .get("/api/table")
                .then(({ data }) => {
                    if (data.length >= 0) {
                        this.loading = false;
                        this.tables = data;
                    }
                })
                .catch((error) => console.log(error));
        },

        deleteAction(id) {
            if (confirm("هل تريد الحذف؟لايمكن الاستعاده مره اخرى.")) {
                axios
                    .delete("/api/table/" + id)
                    .then(() => {
                        this.tables = this.tables.filter((table) => {
                            return table.id != id;
                        });
                        Notification.successMsg("تم الحذف بنجاح ");
                    })
                    .catch(() => {
                        Notification.errorMsg("لايمكن الحذف");
                    });
            }
        },
    },
};
</script>
<style>
a,
a:hover {
    text-decoration: none;
    font-weight: bolder;
}

.bg-info {
    width: 100%;
    height: 100%;
    position: absolute;
    overflow: hidden;
}

.spinner-border {
    margin: 50vh auto !important;
}

table.table-fit {
    width: auto !important;
    table-layout: auto !important;
}

table.table-fit thead th,
table.table-fit tfoot th {
    width: auto !important;
}

table.table-fit tbody td,
table.table-fit tfoot td {
    width: auto !important;
}
</style>
