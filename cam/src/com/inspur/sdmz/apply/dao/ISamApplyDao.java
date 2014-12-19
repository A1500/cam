package com.inspur.sdmz.apply.dao;

import java.util.List;

import org.loushang.demo.co.Co;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;

import com.inspur.sdmz.apply.data.SamApply;

/*
 * 救助业务
 */
public interface ISamApplyDao extends BaseCURD<SamApply>{
	/**
	 * @title:
	 * @description:根据id删除主表一条记录
	 * @author:
	 * @since:2011-06-08
	 * @param
	*/
	public void delete(String[] delIds);/**
	 * @title:
	 * @description:增加主表信息时页面自动加载值
	 * @author:
	 * @since:2011-06-08
	 * @param
	*/
	
	public DataSet initInsertJsp(SamApply samapply);
	/**
	 * @title:
	 * @description:查询上级单位
	 * @author:
	 * @since:2011-06-08
	 * @param
	*/
	public DataSet querySjdw();
	/**
	 * @title:
	 * @description:查询平级单位的方法
	 * @author:
	 * @since:2011-06-08
	 * @param
	*/
	public DataSet queryPjdw();
	/**
	 * @title:
	 * @description:查询下级单位的方法
	 * @author:
	 * @since:2011-06-08
	 * @param
	*/
	public DataSet queryXjdw();
	/**
	 * @description提交审核Dao接口
	 * @title:
	 * @since:2011-06-08
	 * @param
	*/
	public void tjsh(String[] delIds);
	/**
	 * @title:
	 * @description:添加是否回访
	 * @author:
	 * @since:2011-06-08
	 * @param
	*/
	public void ywhf(SamApply samapply,String[] applyId);
}
