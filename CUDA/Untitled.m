LocalSize = uint8(20);
ResultBox1 = imread('K:\Êý¾Ý\shujubeifen\original\bmx\bmx_06668.jpg');
ResultBox2 = imread('C:\Users\qduwg\Documents\WeChat Files\wxid_ih0tim6qqvuz22\Files\zbmx\bmx_06668.png');
ResultBox3=pixelAssign(ResultBox2,ResultBox1,LocalSize,25);%cuda and C program
ResultBox3 = MatrixNormalization(ResultBox3);
ResultBox3 = MatrixNormalization(ResultBox3);