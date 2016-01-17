<template>
  <div class='header'>
    <a v-link='back' v-if='back'>
      <img :src='backIcon' />
    </a>
    <h1 :class="{ 'no-back': !back }">
      {{ title }}
    </h1>
  </div>
</template>

<script>
import backIcon from 'src/assets/ic_navigate.svg'

export default {
  data () {
    return {
      backIcon
    }
  },
  props: ['title', 'back']
}
</script>

<style scoped>
.header {
  height: 60px;
  background-color: #2196F3;
}

.header a {
  display: inline-block;
}

.header h1 {
  display: inline-block;
  padding: 15px 5px;
  color: white;
  margin: 0;
  font-size: 24px;
}

.header h1.no-back {
  margin-left: 24px;
}
</style>
