import React from 'react'
import PropTypes from 'prop-types'

export default class QuestionsComponent extends React.Component {

  constructor(props) {
    super(props)
  }

  static get propTypes() {
    return {
      question: PropTypes.object.isRequired
    }
  }

  render() {
    const { question, currentStep, step } = this.props;
    const answers = question.answer_choices.map((answer, index) => {
      const id = 'answerChoice-' + question.id + '-' + index
      const name = 'question-' + question.id
      return (
        <div key={index}>
          <input type="radio" id={id} name={name}
            data-questionId={question.id} value={answer}
            onChange={this.props.onAnswerChange} />
          <label for={id}>{answer}</label>
        </div>
      )
    })
    const display = currentStep != step ? 'none' : 'block'
    return (
      <div style={{ display }}>
        <strong>{question.body}</strong>
        <div>
          {answers}
        </div>
      </div>
    )
  }
}
