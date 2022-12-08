도메인 파일에서는 
predicates에 alive를 이용하여 alive면 행동을 취할수 있게 하였습니다.
이외에도 여러 조건을 사용하여 action 후 predicates의 상태들이 변화하는식으로 하여 문제를 해결하였습니다. 

문제파일에서는 초기init 상태에 objects가 어떤 상태인지 구체적으로 표현하여
오류를 없앴습니다. ex) (alive granny) (ispredator wolf)
goal 상태에서는 문제 순서에따라 차례대로 상태를 입력하였습니다.

어려웠던점)사건순서에 따라 진행되야해서 문제진행할때마다 계속 predicates를 추가할때 오류가 많이나
	 어려움을 겪었습니다.