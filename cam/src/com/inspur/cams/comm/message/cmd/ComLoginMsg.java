package com.inspur.cams.comm.message.cmd;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.persistent.util.domain.BaseJdbcDao;

import com.inspur.cams.comm.util.BspUtil;

/**
 * 首页登录代办任务列表弹窗
 * @author zhangdd
 * @date 2014-2-25
 */
public class ComLoginMsg extends BaseJdbcDao{
	public ComLoginMsg() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	protected void initDao() {
		// TODO Auto-generated method stub
	}

	public DataSet queryMsg() {
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT T.MESSAGE_TITLE,M.ATTACHMENT_ID,M.FILE_NAME FROM COM_MESSAGE T LEFT JOIN COM_MESSAGE_ATTACHMENT M ON M.MESSAGE_ID=T.MESSAGE_ID WHERE T.IF_SHOW='1' ORDER BY T.SERIAL_NUM ");

		DataSet ds = new DataSet();
		ds = this.executeDataset(sql.toString(), true);
		return ds;
	}
	
	public DataSet queryDrelMsg(){
		DataSet ds = new DataSet();
 		String organCode = BspUtil.getOrganCode();
// 		System.out.println(organCode);
		StringBuffer sql = new StringBuffer();
		if("370000000000".equals(organCode)){
			sql.append("select  ORGAN_CODE, c.name as ORGAN_NAME,CITY_NUM , COUNTRY_NUM,FIVE_NUM,(CITY_NUM+COUNTRY_NUM+FIVE_NUM) as TOTAL_NUM from V_DREL_DEAD_OBJECT t ,dic_city c where c.id=t.ORGAN_CODE and substr(t.ORGAN_CODE,5,8)='00000000' order by  t.ORGAN_CODE\n");
			ds = this.executeDataset(sql.toString(), true);
		}else if(organCode != null && !organCode.equals("")&&"00000000".equals(organCode.substring(4, 12))){
			sql.append("select  ORGAN_CODE, c.name as ORGAN_NAME,CITY_NUM , COUNTRY_NUM,FIVE_NUM,(CITY_NUM+COUNTRY_NUM+FIVE_NUM) as TOTAL_NUM  from V_DREL_DEAD_OBJECT t ,dic_city c where c.id=t.ORGAN_CODE and instr(t.ORGAN_CODE,"+organCode+")=1 order by  t.ORGAN_CODE");
			ds = this.executeDataset(sql.toString(), true);
		}else {
			sql.append("select  ORGAN_CODE, c.name as ORGAN_NAME,CITY_NUM , COUNTRY_NUM,FIVE_NUM,(CITY_NUM+COUNTRY_NUM+FIVE_NUM) as TOTAL_NUM  from V_DREL_DEAD_OBJECT t ,dic_city c where c.id=t.ORGAN_CODE and instr(t.ORGAN_CODE,"+organCode+")=1 order by  t.ORGAN_CODE");
			ds = this.executeDataset(sql.toString(), true);
		}
		//sql.append("select ORGAN_CODE, c.name as ORGAN_NAME,DISABILITY , DEPENDANT,DEMOBILIED,DEMOBILIZEDILLNESS, WAR,TESTED,SOLDIER, MARTYR from V_BPT_DEAD_OBJECT t ,dic_city c where c.id=t.ORGAN_CODE and substr(t.ORGAN_CODE,5,8)='00000000' \n");
		//ds = this.executeDataset(sql.toString(), true);
		return ds;
	}
	//核对婚姻信息
	public DataSet queryMarryMsg(){
		String organCode = BspUtil.getOrganCode();
		 StringBuffer sql = new StringBuffer();
		 sql.append("select count(t.family_id) AS MARRY_NUM from baseinfo_family t ");
		 sql.append("left join rc_marry m on t.family_card_no = m.cert_num_man  or t.family_card_no = m.cert_num_woman ");
		 sql.append(" where t.people_num='1' ");
		 sql.append(" and m.id is not null ");
		 sql.append(" and m.op_date = (select max(ma.op_date) from rc_marry ma  where t.family_card_no = ma.cert_num_man or  t.family_card_no = ma.cert_num_woman) ");
		 sql.append(" and (m.op_type ='IA' or m.op_type ='ICA') ");
		 sql.append(" and t.domicile_code like '"+getAreaCodeLikePrefix(organCode)+"%'");
		 DataSet ds =  this.executeDataset(sql.toString(),true);
//		 System.out.println(sql.toString());
		 return ds;
	}
	//查询低收入家庭疑似信息
	public DataSet querySuspectMsg(){
		String organCode = BspUtil.getOrganCode();
		 StringBuffer sql = new StringBuffer();
		 sql.append("select count(t.ensure_id) SUSPECT_NUM from ensure_to_client t where t.current_status = '1' and t.read_status='1' and t.area_code like '"+getAreaCodeLikePrefix(organCode)+"%'");
//		 System.out.println(sql.toString());
		 DataSet ds =  this.executeDataset(sql.toString(),true);
		 return ds;
	}
	 private String getAreaCodeLikePrefix(String areaCode) {
       if(areaCode.endsWith("0000000000")){//省370000000000
			return areaCode.substring(0,2);
		} else if (areaCode.endsWith("00000000")){//市370100000000
			return areaCode.substring(0,4);
		} else if (areaCode.endsWith("000000")){//县370104000000
			return areaCode.substring(0,6);
		} else if (areaCode.endsWith("000")){//乡370104003000
			return areaCode.substring(0,9);
		}
       return areaCode;
	}

}
