<template>
  <div class="ts fluid vertically padded heading slate">
    <div class="ts narrow container">
      <div class="header">{{title}}</div>
      <div class="description">
        <span>{{subtitle}}</span>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Header",
  props: {
    title: String,
    subtitle: String
  }
};
</script>

<style scoped>
</style>
