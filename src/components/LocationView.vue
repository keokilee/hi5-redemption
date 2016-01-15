<template>
  <div>
    <h3>{{ location.fullName() }}</h3>
  </div>
</template>

<script>
import store from 'src/store'

export default {
  data () {
    const location = store.state.recyclingCenters.filter(r => r.id === this.$router.params.id)
    return {
      location
    }
  }
}
</script>
