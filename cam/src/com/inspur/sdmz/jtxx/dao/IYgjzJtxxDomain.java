package com.inspur.sdmz.jtxx.dao;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.sdmz.jtxx.data.BaseinfoFamily;
import com.inspur.sdmz.jtxxcyxx.dao.YgjzJtxxCyxx;
import com.inspur.sdmz.jtxxszlx.dao.YgjzJtxxSzlx;
import com.inspur.sdmz.jtxxzrzh.dao.YgjzJtxxZrzh;
import com.inspur.sdmz.jzzs.dao.YgjzJzzs;
import com.inspur.sdmz.jtxx.data.SamPeopleDisability;
import com.inspur.sdmz.ygjzcyxxhbxx.dao.YgjzCyxxHbxx;
import com.inspur.sdmz.ygjzcyxxjyxx.dao.YgjzCyxxJyxx;
import com.inspur.sdmz.ygjzcyxxsgxx.dao.YgjzCyxxSgxx;

/**
 * @title:IYgjzJtxxDomain
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
 public interface IYgjzJtxxDomain {

    public void saveYgjzJtxx(List<BaseinfoFamily> list);
	public void saveYgjzJtxxCyxx(List<YgjzJtxxCyxx> list);
	public DataSet queryYgjzJtxxCyxx(ParameterSet pset);
	public void saveYgjzJtxxCyxxList(BaseinfoFamily ygjzjtxx, List<YgjzJtxxCyxx> list,List<SamPeopleDisability> cjxxlist,List<YgjzCyxxJyxx>YgjzCyxxJyxxList,List<YgjzCyxxHbxx>YgjzCyxxHbxxList,List <YgjzCyxxSgxx>YgjzCyxxSgxxList);

	@Trans
	public void saveYgjzJtxxSzlx(List<YgjzJtxxSzlx> list);
	@Trans
	public DataSet queryYgjzJtxxSzlx(ParameterSet pset);
	public void saveYgjzJtxxSzlxList(BaseinfoFamily ygjzjtxx, List<YgjzJtxxSzlx> list);

	@Trans
	public void saveYgjzJtxxZrzh(List<YgjzJtxxZrzh> list);
	@Trans
	public DataSet queryYgjzJtxxZrzh(ParameterSet pset);
	public void saveYgjzJtxxZrzhList(BaseinfoFamily ygjzjtxx, List<YgjzJtxxZrzh> list);

	@Trans
	public void saveYgjzJzzs(List<YgjzJzzs> list);
	@Trans
	public DataSet queryYgjzJzzs(ParameterSet pset);
	public void saveYgjzJzzsList(BaseinfoFamily ygjzjtxx, List<YgjzJzzs> list);

	public DataSet queryYgjzJtxx(ParameterSet pset);

	public void delete(List<String> list);

 }