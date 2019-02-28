import React from 'react'
import PropTypes from 'prop-types'
import ReactDOM from 'react-dom'
import QuestionComponent from './QuestionComponent'

export default class QuestionsComponent extends React.Component {

  constructor(props) {
    super(props)
    this.state = {
      currentStep: 0
    }
    this._next = this._next.bind(this);
    this._prev = this._prev.bind(this);
  }

  _next() {
    let currentStep = this.state.currentStep;
    let maxStep = this.props.questions.length - 1 // "- 1" because we start from 0
    // Make sure currentStep is set to something reasonable
    if (currentStep >= (maxStep - 1)) {
      currentStep = maxStep;
    } else {
      currentStep = currentStep + 1;
    }

    this.setState({
      currentStep: currentStep
    });
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
      return <QuestionComponent key={question.id} question={question} currentStep={currentStep} step={index}/>
    })
    const lastStep = currentStep == (questions.length - 1)

    return (
      <div>
        <p>Please give answers on folowing questions:</p>
        {questionsBlock}
        <button className="btn" onClick={this._prev}>Prev</button>
        <button className="btn" onClick={this._next}>{lastStep ? 'Save' : 'Next' }</button>
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
