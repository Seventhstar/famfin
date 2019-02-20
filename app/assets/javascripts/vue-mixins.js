var m_created = {
  created: function () {
    this.$root.$on('onInput', this.onInput);
    this.$root.$on('modalYes', this.modalYes);
  },

  methods: {
   formatValue(value, column){
      if (column == 'amount') {
        return to_sum(value)
      }
      return value
    },


    onSubmit(event){
        if (event && !this.formValid) {
          event.preventDefault();
          // console.log('onSubmit', this.noteValid);
          show_ajax_message(this.noteValid, 'error');
        }

      },
  }
}