package com.inspur.sdmz.jtxxcyxx.domain;

 

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.sdmz.jtxxcyxx.dao.YgjzJtxxCyxx;
import com.inspur.sdmz.ygjzcyxxhbxx.dao.YgjzCyxxHbxx;
import com.inspur.sdmz.ygjzcyxxjyxx.dao.YgjzCyxxJyxx;
import com.inspur.sdmz.ygjzcyxxsgxx.dao.YgjzCyxxSgxx;
 

/**
 * @title:IYgjzJtxxCyxxDomain
 * @description:
 * @author:
 * @since:2011-04-19
 * @version:1.0
*/
 public interface IYgjzJtxxCyxxDomain {
    public void save(List<YgjzJtxxCyxx> list);
	 
    public void saveYgjzJtxxCyxx(List<YgjzJtxxCyxx> list);
	//public void saveYgjzCyxxCjxx(List<YgjzCyxxCjxx> list);
	public DataSet queryYgjzCyxxCjxx(ParameterSet pset);
	//public void saveYgjzCyxxCjxxList(YgjzJtxxCyxx ygjzjtxxcyxx, List<YgjzCyxxCjxx> list);
	@Trans
	public DataSet queryYgjzCyxxJyxx(ParameterSet pset);
	public DataSet queryYgjzJtxxCyxx(ParameterSet pset);
	@Trans
	public void saveYgjzCyxxJyxx(List<YgjzCyxxJyxx> list);
	@Trans
	public void saveYgjzCyxxHbxx(List<YgjzCyxxHbxx> list);
	@Trans
	public DataSet queryYgjzCyxxHbxx(ParameterSet pset);
	public void saveYgjzCyxxHbxxList(YgjzJtxxCyxx ygjzjtxxcyxx, List<YgjzCyxxHbxx> list);

	@Trans
	public void saveYgjzCyxxSgxx(List<YgjzCyxxSgxx> list);
	@Trans
	public DataSet queryYgjzCyxxSgxx(ParameterSet pset);
	public void saveYgjzCyxxSgxxList(YgjzJtxxCyxx ygjzjtxxcyxx, List<YgjzCyxxSgxx> list);

	public void saveYgjzCyxxJyxxList(YgjzJtxxCyxx ygjzjtxxcyxx, List<YgjzCyxxJyxx> list);

 }