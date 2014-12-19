package com.inspur.sdmz.jzfa.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.sdmz.jzfa.data.ComPlanOrgan;

/**
 * @title:IComPlanOrganDao
 * @description:
 * @author:
 * @since:2011-09-17
 * @version:1.0
*/
 public interface IComPlanOrganDao extends BaseCURD<ComPlanOrgan>{
	public void save(List<ComPlanOrgan> list);
	
	public void deleteById(String id);
}

