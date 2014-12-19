package com.inspur.sdmz.jtxx.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.sdmz.jtxx.dao.IYgjzCyxxCjxxDao;
import com.inspur.sdmz.jtxx.dao.IYgjzCyxxHbxxDao;
import com.inspur.sdmz.jtxx.dao.IYgjzCyxxJyxxDao;
import com.inspur.sdmz.jtxx.dao.IYgjzCyxxSgxxDao;
import com.inspur.sdmz.jtxx.dao.IYgjzJtxxCyxxDao;
import com.inspur.sdmz.jtxx.data.SamPeopleDisability;
import com.inspur.sdmz.jtxx.data.SamPeopleDisease;
import com.inspur.sdmz.jtxx.data.SamPeopleEdu;
import com.inspur.sdmz.jtxx.data.SamPeopleAccident;
import com.inspur.sdmz.jtxx.data.BaseinfoPeople;
import com.inspur.sdmz.jtxx.domain.IYgjzJtxxCyxxDomain;


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
	@Reference
	public void saveYgjzCyxxCjxx(List<SamPeopleDisability> list) {
		if (list != null && !list.isEmpty()) {
			this.ygjzcyxxcjxxDao.save(list);
		}
	}

	public DataSet queryYgjzCyxxCjxx(ParameterSet pset) {
		return ygjzcyxxcjxxDao.query(pset);
	}
	public void saveYgjzCyxxCjxxList(BaseinfoPeople ygjzjtxxcyxx, List<SamPeopleDisability> line) {
		List ygjzjtxxcyxxList = new ArrayList();
		ygjzjtxxcyxxList.add(ygjzjtxxcyxx);
		this.ygjzjtxxcyxxDao.save(ygjzjtxxcyxxList);
		if (line != null && !line.isEmpty()) {
			this.ygjzcyxxcjxxDao.save(line);
		}
	}

	public DataSet queryYgjzJtxxCyxx(ParameterSet pset) {
		return ygjzjtxxcyxxDao.query(pset);
	}

	public void save(List<BaseinfoPeople> list) {
		this.ygjzjtxxcyxxDao.save(list);

	}
	/**
	 *
	 * 业务添加
	 */
	public void saveYgjzJtxxCyxx(List<BaseinfoPeople> list) {
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
	public void saveYgjzCyxxJyxx(List<SamPeopleEdu> list) {
		if (list != null && !list.isEmpty()) {
			this.ygjzcyxxjyxxDao.save(list);
		}

	}
	public void saveYgjzCyxxHbxx(List<SamPeopleDisease> list) {
		if (list != null && !list.isEmpty()) {
			this.ygjzcyxxhbxxDao.save(list);
		}

	}
	public void saveYgjzCyxxHbxxList(BaseinfoPeople ygjzjtxxcyxx,
			List<SamPeopleDisease> list) {
	}
	public void saveYgjzCyxxSgxx(List<SamPeopleAccident> list) {
		if (list != null && !list.isEmpty()) {
			this.ygjzcyxxsgxxDao.save(list);
		}
	}
	public DataSet queryYgjzCyxxHbxx(ParameterSet pset) {
		return ygjzcyxxhbxxDao.query(pset);
	}
	public DataSet queryYgjzCyxxSgxx(ParameterSet pset) {
		return ygjzcyxxsgxxDao.query(pset);
	}

	public void saveYgjzCyxxSgxxList(BaseinfoPeople ygjzjtxxcyxx,
			List<SamPeopleAccident> list) {

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
	public void saveYgjzCyxxJyxxList(BaseinfoPeople ygjzjtxxcyxx, List<SamPeopleEdu> line) {
		List ygjzjtxxcyxxList = new ArrayList();
		ygjzjtxxcyxxList.add(ygjzjtxxcyxx);
		this.ygjzjtxxcyxxDao.save(ygjzjtxxcyxxList);
		if (line != null && !line.isEmpty()) {
			this.ygjzcyxxjyxxDao.save(line);
		}
	}

}