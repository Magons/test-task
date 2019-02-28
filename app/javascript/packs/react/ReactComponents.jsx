import React from 'react'
import HelloComponent from './HelloComponent'
import QuestionsComponent from './QuestionsComponent'

export default function init() {
  window.HelloComponent = HelloComponent;
  window.QuestionsComponent = QuestionsComponent;
}
