<template>
  <div class='search'>
    <i class="material-icons">search</i>
    <input type='text' v-model='place' placeholder='Search Near a Location'>
    <span class='highlight'></span>
    <span class='bar'></span>
  </div>
</template>

<script>
export default {
  data () {
    return {
      place: ''
    }
  }
}
</script>

<style scoped>
.search {
  position: relative;
  margin: 25px 10px 25px 20px;
}

.search input {
  font-size: 1.1rem;
  padding-bottom: 10px;
  display: inline-block;
  width: calc(100% - 42px);
  border: none;
  border-bottom: 1px solid #757575;
}

.search input:focus {
  outline: none;
}

.search label {
  font-size: 1.1rem;
  color: #999;
  font-weight: normal;
  position: absolute;
  pointer-events: none;
  left: 5px;
  top: 10px;
  transition: 0.25s ease all;
}

.search input:focus ~ label {
  top: -20px;
  font-size: 0.9rem;
  color: #2979FF;
}

.search input:focus ~ .bar:before, .search input:focus ~ .bar:after {
  width: 50%;
}

.bar {
  position: relative;
  display: block;
  width: calc(100% - 40px);
}

.bar:before, .bar:after {
  content: '';
  height: 2px;
  width: 0;
  bottom: 1px;
  position: absolute;
  background: #2979FF;
  transition: 0.2s ease all;
}

.bar:before {
  left: calc(50% + 26px);
}

.bar:after {
  right: calc(50% - 26px);
}
</style>
