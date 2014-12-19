package com.inspur.sdmz.jtxx.domain.support;


import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.sdmz.jtxx.dao.IYgjzCyxxCjxxDao;
import com.inspur.sdmz.jtxx.dao.IYgjzJtxxCyxxDao;
import com.inspur.sdmz.jtxx.data.SamPeopleDisability;
import com.inspur.sdmz.jtxx.data.SamPeopleDisease;
import com.inspur.sdmz.jtxx.data.SamPeopleEdu;
import com.inspur.sdmz.jtxx.data.SamPeopleAccident;
import com.inspur.sdmz.jtxx.data.BaseinfoPeople;
import com.inspur.sdmz.jtxx.domain.IYgjzCyxxCjxxDomain;


/**
 * @title:YgjzJtxxCyxxDomain
 * @description:
 * @author:
 * @since:2011-04-19
 * @version:1.0
*/
 public class YgjzCyxxCjxxDomain implements IYgjzCyxxCjxxDomain {

	private IYgjzJtxxCyxxDao ygjzjtxxcyxxDao;

	private IYgjzCyxxCjxxDao ygjzcyxxcjxxDao;

	//DAO
	@Reference
	public void setYgjzJtxxCyxxDao(IYgjzJtxxCyxxDao ygjzjtxxcyxxDao) {
		this.ygjzjtxxcyxxDao = ygjzjtxxcyxxDao;
	}
	@Reference
	public void setYgjzCyxxCjxxDao(IYgjzCyxxCjxxDao ygjzcyxxcjxxDao) {
		this.ygjzcyxxcjxxDao = ygjzcyxxcjxxDao;
	}

	//

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
	public DataSet queryYgjzCyxxHbxx(ParameterSet pset) {
		// TODO Auto-generated method stub
		return null;
	}
	public DataSet queryYgjzCyxxJyxx(ParameterSet pset) {
		// TODO Auto-generated method stub
		return null;
	}
	public DataSet queryYgjzCyxxSgxx(ParameterSet pset) {
		// TODO Auto-generated method stub
		return null;
	}
	public void saveYgjzCyxxHbxx(List<SamPeopleDisease> list) {
		// TODO Auto-generated method stub

	}
	public void saveYgjzCyxxHbxxList(BaseinfoPeople ygjzjtxxcyxx,
			List<SamPeopleDisease> list) {
		// TODO Auto-generated method stub

	}
	public void saveYgjzCyxxJyxx(List<SamPeopleEdu> list) {
		// TODO Auto-generated method stub

	}
	public void saveYgjzCyxxSgxx(List<SamPeopleAccident> list) {
		// TODO Auto-generated method stub

	}
	public void saveYgjzCyxxSgxxList(BaseinfoPeople ygjzjtxxcyxx,
			List<SamPeopleAccident> list) {
		// TODO Auto-generated method stub

	}
	public void saveYgjzCyxxJyxxList(BaseinfoPeople ygjzjtxxcyxx,
			List<SamPeopleEdu> list) {
		// TODO Auto-generated method stub

	}

}