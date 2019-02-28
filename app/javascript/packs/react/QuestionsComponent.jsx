import React from 'react'
import PropTypes from 'prop-types'
import ReactDOM from 'react-dom'
import axios from 'axios'
import QuestionComponent from './QuestionComponent'

export default class QuestionsComponent extends React.Component {

  constructor(props) {
    super(props)
    this.state = {
      currentStep: 0,
      answers: {}
    }
    this._next = this._next.bind(this);
    this._prev = this._prev.bind(this);
    this.onAnswerChange = this.onAnswerChange.bind(this);
    this.validateAnswer = this.validateAnswer.bind(this);
    this.handleSave = this.handleSave.bind(this);
  };

  onAnswerChange(e) {
    let answers = this.state.answers
    const questionId = e.target.dataset.questionid
    answers[questionId] = { question_id: questionId, body: e.target.value }
    this.setState({ answers })
  }

  handleSave() {
    axios.post('/api/v1/answers', {
      answers: this.state.answers
    })
      .then(function (response) {
        window.location.href = '/'
      })
      .catch(function (error) {
        growl('Alert', 'Something went wrong.')
      });
  }

  validateAnswer() {
    const questions = this.props.questions
    let { currentStep, answers } = this.state
    const question = questions[currentStep]
    if (answers[question.id]) {
      return true
    } else {
      growl('Alert', 'Please choose answer!')
      return false
    }
  }

  _next() {
    if (this.validateAnswer()) {
      let { currentStep } = this.state
      let maxStep = this.props.questions.length - 1 // "- 1" because we start from 0
      if (currentStep == maxStep) {
        this.handleSave()
      } else if (currentStep >= (maxStep - 1)) { // Make sure currentStep is set to something reasonable
        currentStep = maxStep;
      } else {
        currentStep = currentStep + 1;
      }

      this.setState({
        currentStep: currentStep
      });
    }
  }

  _prev() {
    let currentStep = this.state.currentStep;
    if (currentStep <= 0) {
      currentStep = 0;
    } else {
      currentStep = currentStep - 1;
    }

    this.setState({
      currentStep: currentStep
    });
  }

  static get propTypes() {
    return {
      questions: PropTypes.array.isRequired
    }
  }

  render() {
    const questions = this.props.questions;
    const currentStep = this.state.currentStep
    const questionsBlock = questions.map((question, index) => {
      return <QuestionComponent
        key={question.id}
        question={question}
        currentStep={currentStep}
        step={index}
        onAnswerChange={this.onAnswerChange}/>
    })
    const lastStep = currentStep == (questions.length - 1)

    return (
      <div>
        <p>Please give answers on folowing questions:</p>
        <form>
          {questionsBlock}
        </form>
        <div className="buttons">
          <button className="btn btn-primary" onClick={this._prev}>Prev</button>
          <button className="btn btn-primary" onClick={this._next}>{lastStep ? 'Save' : 'Next'}</button>
        </div>
      </div>
    )
  }

  static injectToPage(selector, props) {
    $(() => {
      let div = $('<div>')
      let x = $(selector)
      if (x.length > 0) {
        x.replaceWith(div)
        ReactDOM.render(
          <QuestionsComponent questions={props.questions} />,
          div[0],
        )
      }
    })
  }
}
