<template>
    <div>
        <returnC v-if="mixins.country == 1"></returnC>
        <processC v-else></processC>
    </div>
</template>

<script>
import returnC from "./cashier_return.vue";
import processC from "./cashier_process.vue";

export default {
    components: {  returnC, processC },

    async created() {
        if (!User.loggedIn()) {
            await this.$router.push("/");
        }
        await this.getMixins();
    },

    data() {
        return {
            mixins: {},
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
    },
};
</script>
