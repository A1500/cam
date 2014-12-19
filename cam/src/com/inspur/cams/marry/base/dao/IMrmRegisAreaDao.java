package com.inspur.cams.marry.base.dao;

import java.math.BigDecimal;
import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.marry.base.data.MrmRegisArea;

/**
 * @title:IMrmRegisAreaDao
 * @description:
 * @author:
 * @since:2011-11-28
 * @version:1.0
*/
 public interface IMrmRegisAreaDao extends BaseCURD<MrmRegisArea>{
	public void save(List<MrmRegisArea> list);
	
	public BigDecimal getMarryArea(String deptId) ;//候登区面积+结婚登记区面积
	
	public BigDecimal getLhArea(String deptId);//离婚登记区面积
	
	public BigDecimal getLhWindow(String deptId);//离婚登记区窗口
		 
	public BigDecimal getMarryWindow(String deptId);//结婚登记区窗口数
		 
	public BigDecimal getHdChair(String deptId);//候登区座椅
	
	public List getFdsArea(String deptId);//婚姻家庭辅导室、间数
		 
	public BigDecimal getBzdtArea(String deptId);//颁证大厅面积
	
	public BigDecimal getTbChair(String deptId);//填表区座椅
	
	public String getdnDyjCard(String deptId);  //电脑、打印机 、身份识别系统
	
	public String getWcStation(String deptId);//卫生间位置
	
	public BigDecimal getCountArea(String deptId);//总面积
	
	public BigDecimal getWzatd(String deptId) ;// 有无 无障碍通道
	
	public BigDecimal getBzChair(String deptId);
}

