./svm_python_learn -c 0.01 multi-example/train.dat multi-example/model
./svm_python_classify multi-example/test.dat multi-example/model multi-example/prediction
less multi-example/prediction
