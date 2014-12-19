package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.sorg.base.domain.ISomOrganDomain;

/**
 * 社会组织信息查询cmd
 * @author shgtch
 * @date 2011-8-12
 */
public class SomOrganQueryCmd extends BaseQueryCommand {

	ISomOrganDomain somOrganDomain = ScaComponentFactory.getService(ISomOrganDomain.class, "somOrganDomain/somOrganDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		String morgArea=BspUtil.getCorpOrgan().getOrganCode();
		pset.setParameter("MORG_AREA@like",getMorgAreaCode(morgArea));
		return somOrganDomain.query(pset);
	}
	
	public DataSet queryOrgan() {
		ParameterSet pset = getParameterSet();
		String morgArea=BspUtil.getCorpOrgan().getOrganCode();
		pset.setParameter("MORG_AREA@like",getMorgAreaCode(morgArea));
		return somOrganDomain.queryOrgan(pset);
	}
	
	public DataSet queryOrganOnline() {
		ParameterSet pset = getParameterSet();
		return somOrganDomain.queryOrgan(pset);
	}
	
	/**
	 * 前台行政区划作为查询条件传递过来的查询
	 * 限定条件：前台setParameter格式应为“MORG_AREA@like”
	 * 逻辑：前台没有作为参数传递的话，按照登陆用户的行政区划添加过滤。传过来的话，如果是本级类型的，转化行政区划作为参数查询，正常类型的则不做处理，按照前台传递过来的参数查询
	 * @return
	 */
	public DataSet queryOrganWithAreaCodeSearchCondition() {
		ParameterSet pset = getParameterSet();
		if(pset.getParameter("MORG_AREA@like") != null){
			String areaCode = (String)pset.getParameter("MORG_AREA@like");
			if(areaCode.equals("")){
				String morgArea=BspUtil.getCorpOrgan().getOrganCode();
				pset.setParameter("MORG_AREA@like",getMorgAreaCode(morgArea));
			}else{
				if(checkIfCityLevel(areaCode)){
					pset.setParameter("MORG_AREA@like",areaCode.substring(0, 6)+"000000");
				}
			}
		}else{
			String morgArea=BspUtil.getCorpOrgan().getOrganCode();
			pset.setParameter("MORG_AREA@like",getMorgAreaCode(morgArea));
		}
		
		return somOrganDomain.queryOrgan(pset);
	}
	
	/**
	 * 行政区划表中有市本级的，市本级或显本级代码如370200999000，通过999判断是否市\县本级
	 * @param areaCode
	 * @return
	 */
	private boolean checkIfCityLevel(String areaCode){
		if(areaCode.substring(6, 9).equals("999")){
			return true;
		}
		return false;
	}
	

	public DataSet queryMain() {
		ParameterSet pset = getParameterSet();
		String morgArea=BspUtil.getCorpOrgan().getOrganCode();
		pset.setParameter("MORG_AREA@like",getMorgAreaCode(morgArea));
		return somOrganDomain.queryMain(pset);
	}

	public DataSet queryBranch() {
		ParameterSet pset = getParameterSet();
		String morgArea=BspUtil.getCorpOrgan().getOrganCode();
		pset.setParameter("MORG_AREA@like",getMorgAreaCode(morgArea));
		return somOrganDomain.queryBranch(pset);
	}
	
	public DataSet totalQueryBranch() {
		ParameterSet pset = getParameterSet();
		String morgArea=BspUtil.getCorpOrgan().getOrganCode();
		pset.setParameter("MORG_AREA@like",getMorgAreaCode(morgArea));
		return somOrganDomain.totalQueryBranch(pset);
	}
	
	public DataSet queryHis() {
		ParameterSet pset = getParameterSet();
		String morgArea=BspUtil.getCorpOrgan().getOrganCode();
		pset.setParameter("MORG_AREA@like",getMorgAreaCode(morgArea));
		return somOrganDomain.queryHis(pset);
	}
	
	private String getMorgAreaCode(String morgArea){
		String[] ss=morgArea.split("");
		int num=0;
		for(int i=0;i<ss.length;i++){
			if( !"0".equals(ss[i]) ){
				if(num<i){
					num=i;
				}
			}
		}
		return morgArea.substring(0,num);
	}
}