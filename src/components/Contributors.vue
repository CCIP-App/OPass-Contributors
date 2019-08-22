<template>
  <div class="ts Contributors four wide column">
    <h3 class="ts dividing header">{{ this.repo.name }}</h3>
    <div class="ts selection items">
      <Contributor
        v-for="user in repo.users"
        v-bind:username="user.login"
        v-bind:users="users"
        v-bind:key="user.login"
      />
    </div>
  </div>
</template>

<script>
import Contributor from "./Contributor.vue";

export default {
  name: "Contributors",
  components: {
    Contributor
  },
  props: {
    repo: Object,
    users: Object
  }
};
</script>

<style scoped>
.Contributors {
  margin-top: 3em;
}
</style>
