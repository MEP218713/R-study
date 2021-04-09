library(ggplot2)
N <- 20
df1 <- data.frame(x=sort(rnorm(N)),y=sort(rnorm(N)))
df2 <- data.frame(x=df1$x+0.1*rnorm(N),y=df1$y+0.1*rnorm(N))

p1 <- ggplot(df1,aes(x,y,color=x+y))+
  geom_line(size=1)+
  geom_point(shape=16,size=5)+
  guides(color=guide_colorbar(title = "Point\nLine"))+
  labs(title = "所有图层共享数据源和视觉通道映射")

p2 <- ggplot(df1,aes(x,y))+
  geom_line(aes(color=x+y),size=1)+
  geom_point(aes(fill=x+y),size=5,color="black",shape=21)+
  scale_fill_distiller(name="Point",palette="YlOrRd")+
  scale_color_distiller(name="Line",palette = "Blues")+
  labs(title="所有图层仅共享数据源")

p3 <- ggplot()+
  geom_line(aes(x,y,color=x+y),df1,size=1)+
  geom_point(aes(x,y,fill=x+y),df2,color="black",shape=21,size=5)+
  scale_fill_distiller(name="Point",palette = "YlOrRd")+
  scale_color_distiller(name="Line",palette = "Blues")+
  labs(title="各图层对象均使用独立的数据源与视觉通道映射")

library(gridExtra) 
grid.arrange(p1,p2,p3, ncol = 3, nrow = 1)