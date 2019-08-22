<template>
  <a class="Contributor item" v-if="user.name" v-bind:href="link">
    <div class="ts mini image">
      <img v-bind:src="user.avatar_url" />
    </div>
    <div class="content">
      <div class="header">{{user.name}}</div>
      <div class="extra">@{{user.login}}</div>
    </div>
  </a>
</template>

<script>
export default {
  name: "Contributor",
  props: ["username", "users"],
  computed: {
    user() {
      return this.users[this.username];
    },
    link() {
      return "https://github.com/" + this.users[this.username].login;
    }
  }
};
</script>

<style scoped>
</style>
