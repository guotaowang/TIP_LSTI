function res_all =  PredictHighVec(net,batch_vector)

num_boxes = size(batch_vector, 1);

batch_size = 100;
num_batches = ceil(num_boxes / batch_size);
batch_padding = batch_size - mod(num_boxes, batch_size);
if batch_padding == batch_size
  batch_padding = 0;
end

batches = cell(num_batches, 1);
for batch = 1:num_batches
  batch_start = (batch-1)*batch_size+1;
  batch_end = min(num_boxes, batch_start+batch_size-1);
  for j = batch_start:batch_end
    pic_data(1,1,:) = batch_vector(j,:);
    picture_data(:,:,:, j-batch_start+1) =pic_data;
  end
      batches{batch} = single(picture_data);
end
res_all = [];
for i = 1:length(batches)
    res = net.forward(batches(i)); 
    res = res{1}';
    if i == length(batches)
        if batch_padding > 0
          res = res(1:end-batch_padding,:);
        end
    end
    res_all = [res_all; res];
end