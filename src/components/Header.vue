<template>
  <div class='header'>
    <h1>{{ title }}</h1>
  </div>
</template>

<script>
export default {
  data () {
    return {
      title: 'Redeem HI5'
    }
  }
}
</script>

<style scoped>
.header {
  background-color: #2196F3;
}

.header h1 {
  padding: 15px 20px;
  color: white;
  margin: 0;
  font-size: 24px;
}
</style>
