<template lang="jade">
.header
  div(v-if="back")
    a(v-link="back")
      img(:src="backIcon")

  h2(:class="{ 'no-back': !back }") {{ title }}
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
  height: 4.0rem;
  background-color: #2196F3;
  display: flex;
  align-items: center;
}

.header img {
  height: 32px;
  padding: 0 5px;
}

.header h2 {
  flex: 1;
  padding: 15px 5px 15px 0;
  color: white;
  margin: 0;

  &.no-back {
    margin-left: 24px;
  }
}
</style>
