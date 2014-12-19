package com.inspur.sdmz.jtxxcyxx.domain;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.sdmz.jtxx.dao.IYgjzCyxxCjxxDao;
import com.inspur.sdmz.jtxxcyxx.dao.IYgjzJtxxCyxxDao;
import com.inspur.sdmz.jtxxcyxx.dao.YgjzJtxxCyxx;
import com.inspur.sdmz.ygjzcyxxhbxx.dao.IYgjzCyxxHbxxDao;
import com.inspur.sdmz.ygjzcyxxhbxx.dao.YgjzCyxxHbxx;
import com.inspur.sdmz.ygjzcyxxjyxx.dao.IYgjzCyxxJyxxDao;
import com.inspur.sdmz.ygjzcyxxjyxx.dao.YgjzCyxxJyxx;
import com.inspur.sdmz.ygjzcyxxsgxx.dao.IYgjzCyxxSgxxDao;
import com.inspur.sdmz.ygjzcyxxsgxx.dao.YgjzCyxxSgxx;
 

/**
 * @title:YgjzJtxxCyxxDomain
 * @description:
 * @author:
 * @since:2011-04-19
 * @version:1.0
*/
 public class YgjzJtxxCyxxDomain implements IYgjzJtxxCyxxDomain {

	private IYgjzJtxxCyxxDao ygjzjtxxcyxxDao;
	//残疾信息
	private IYgjzCyxxCjxxDao ygjzcyxxcjxxDao;
	//教育信息
	private IYgjzCyxxJyxxDao ygjzcyxxjyxxDao;
	//患病信息
	private IYgjzCyxxHbxxDao ygjzcyxxhbxxDao;
	//事故信息
	private IYgjzCyxxSgxxDao ygjzcyxxsgxxDao;
	
	 
	@Reference
	public void setYgjzJtxxCyxxDao(IYgjzJtxxCyxxDao ygjzjtxxcyxxDao) {
		this.ygjzjtxxcyxxDao = ygjzjtxxcyxxDao;
	}
	@Reference
	public void setYgjzCyxxCjxxDao(IYgjzCyxxCjxxDao ygjzcyxxcjxxDao) {
		this.ygjzcyxxcjxxDao = ygjzcyxxcjxxDao;
	}
	@Reference
	public void setYgjzcyxxjyxxDao(IYgjzCyxxJyxxDao ygjzcyxxjyxxDao) {
		this.ygjzcyxxjyxxDao = ygjzcyxxjyxxDao;
	}
	@Reference
    public void setYgjzcyxxhbxxDao(IYgjzCyxxHbxxDao ygjzcyxxhbxxDao) {
		this.ygjzcyxxhbxxDao = ygjzcyxxhbxxDao;
	}
	@Reference
	public void setYgjzcyxxsgxxDao(IYgjzCyxxSgxxDao ygjzcyxxsgxxDao) {
		this.ygjzcyxxsgxxDao = ygjzcyxxsgxxDao;
	}
	//@Reference
	//public void saveYgjzCyxxCjxx(List<YgjzCyxxCjxx> list) {
	//	if (list != null && !list.isEmpty()) {
	//		this.ygjzcyxxcjxxDao.save(list);
	//	}
	//}
	
	public DataSet queryYgjzCyxxCjxx(ParameterSet pset) {
		return ygjzcyxxcjxxDao.query(pset);
	}
	//public void saveYgjzCyxxCjxxList(YgjzJtxxCyxx ygjzjtxxcyxx, List<YgjzCyxxCjxx> line) {
	//	List ygjzjtxxcyxxList = new ArrayList();
	//	ygjzjtxxcyxxList.add(ygjzjtxxcyxx);
	//	this.ygjzjtxxcyxxDao.save(ygjzjtxxcyxxList);
	//	if (line != null && !line.isEmpty()) {
	//		this.ygjzcyxxcjxxDao.save(line);
	//	}
	//}

	public DataSet queryYgjzJtxxCyxx(ParameterSet pset) {
		return ygjzjtxxcyxxDao.query(pset);
	}
	
	public void save(List<YgjzJtxxCyxx> list) {
		this.ygjzjtxxcyxxDao.save(list);
		
	}
	/**
	 * 
	 * 业务添加
	 */
	public void saveYgjzJtxxCyxx(List<YgjzJtxxCyxx> list) {
		this.ygjzjtxxcyxxDao.save(list);//成员基本信息
	}
	/***
	 * 查询教育信息
	 * @param pset
	 * @return
	 */
	public DataSet queryYgjzCyxxJyxx(ParameterSet pset) {
		return ygjzcyxxjyxxDao.query(pset);
	}
	//
	public void saveYgjzCyxxJyxx(List<YgjzCyxxJyxx> list) {
		if (list != null && !list.isEmpty()) {
			this.ygjzcyxxjyxxDao.save(list);
		}
		
	}
	public DataSet queryYgjzCyxxHbxx(ParameterSet pset) {
		// TODO Auto-generated method stub
		return null;
	}
	public DataSet queryYgjzCyxxSgxx(ParameterSet pset) {
		// TODO Auto-generated method stub
		return null;
	}
	public void saveYgjzCyxxHbxx(List<YgjzCyxxHbxx> list) {
		if (list != null && !list.isEmpty()) {
			this.ygjzcyxxhbxxDao.save(list);
		}
		
	}
	public void saveYgjzCyxxHbxxList(YgjzJtxxCyxx ygjzjtxxcyxx,
			List<YgjzCyxxHbxx> list) {
		// TODO Auto-generated method stub
		
	}
	public void saveYgjzCyxxSgxx(List<YgjzCyxxSgxx> list) {
		if (list != null && !list.isEmpty()) {
			this.ygjzcyxxsgxxDao.save(list);
		}
	}
	public void saveYgjzCyxxSgxxList(YgjzJtxxCyxx ygjzjtxxcyxx,
			List<YgjzCyxxSgxx> list) {
		// TODO Auto-generated method stub
		
	}
	public IYgjzJtxxCyxxDao getYgjzjtxxcyxxDao() {
		return ygjzjtxxcyxxDao;
	}
	public IYgjzCyxxJyxxDao getYgjzcyxxjyxxDao() {
		return ygjzcyxxjyxxDao;
	}
	public void setYgjzjtxxcyxxDao(IYgjzJtxxCyxxDao ygjzjtxxcyxxDao) {
		this.ygjzjtxxcyxxDao = ygjzjtxxcyxxDao;
	}
	public IYgjzCyxxSgxxDao getYgjzcyxxsgxxDao() {
		return ygjzcyxxsgxxDao;
	}
	public IYgjzCyxxHbxxDao getYgjzcyxxhbxxDao() {
		return ygjzcyxxhbxxDao;
	}
	/**
	 * 家庭成员添加
	 * 
	 */
	public void saveYgjzCyxxJyxxList(YgjzJtxxCyxx ygjzjtxxcyxx, List<YgjzCyxxJyxx> line) {
		List ygjzjtxxcyxxList = new ArrayList();
		ygjzjtxxcyxxList.add(ygjzjtxxcyxx);
		this.ygjzjtxxcyxxDao.save(ygjzjtxxcyxxList);
		if (line != null && !line.isEmpty()) {
			this.ygjzcyxxjyxxDao.save(line);
		}
	}
 
}