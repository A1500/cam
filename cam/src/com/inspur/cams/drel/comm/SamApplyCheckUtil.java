package com.inspur.cams.drel.comm;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.persistent.util.domain.BaseJdbcDao;
import com.inspur.cams.drel.application.comm.SamApplyType;
/**
 * 流程当中校验
 * @author yanliangliang
 * @date 2014年7月17日
 *
 */
public class SamApplyCheckUtil extends BaseJdbcDao {
	@Override
	protected void initDao() {
		
	}
	public SamApplyCheckUtil() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
}
	/**
	 * 查询此人能否进行录入
	 * 首先查询是否存在正在申请的业务，如果没有，查询是否正在享受救助
	 * @param  idCard 人员身份证号
	 */ 
	@SuppressWarnings("unchecked")
	public SamCheckLog queryExistApply(String idcard,String applyId){
		SamCheckLog samCheckLog = new SamCheckLog();
		StringBuffer querySql = new StringBuffer();
		querySql.append(" select t.domicile_name,t.family_name,t.family_card_no, t.apply_type from sam_apply_info t where t.is_finish='0' and  t.family_id in(select family_id from baseinfo_people a where a.id_card = ?  and a.family_id is not null ) and t.apply_id != ? ");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 typeList.add(Types.VARCHAR);
		 argsList.add(idcard!=null?idcard:"未知");
		 typeList.add(Types.VARCHAR);
		 argsList.add(applyId!=null?applyId:"未知");
		 
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
		 DataSet ds = executeDataset(querySql.toString(), types, args, true);
		 
		 if(ds.getCount() > 0 ){
			 samCheckLog.setResult(false);
			 StringBuffer context = new StringBuffer();
			 for (int i = 0; i < ds.getCount(); i++) {
				Record r = ds.getRecord(i);
				context.append("此人正在【");
				context.append( (String)r.get("DOMICILE_NAME") );
				context.append("】申请【");
				context.append(toConvertApplyType((String)r.get("APPLY_TYPE")));
				context.append("】户主为【");
				context.append((String)r.get("FAMILY_NAME"));
				context.append(",");
				context.append((String)r.get("FAMILY_CARD_NO"));
				context.append("】");
			}
			samCheckLog.setContext(context.toString()); 
		 }else{
			 samCheckLog = queryInSam(idcard);
		 }
		return samCheckLog;
	}
	
	/**
	 * 根据身份证号查询是否正在享受救助
	 * @param idcard
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private SamCheckLog queryInSam(String idcard) {
		SamCheckLog samCheckLog = new SamCheckLog();
		 StringBuffer sql = new StringBuffer();
		 sql.append("SELECT get_city_name(A.Domicile_Code) domicile_name,B.FAMILY_CARD_NO,B.FAMILY_NAME,A.Begin_Date , a.assistance_type FROM SAM_FAMILY_TREATMENT A  ,BASEINFO_FAMILY_ARCHIVE B WHERE A.FAMILY_ID = B.FAMILY_ID   AND A.APPLY_ID = B.APPLY_ID     AND A.BEGIN_DATE <= to_char(sysdate,'yyyy-mm')    AND A.END_DATE >= to_char(sysdate,'yyyy-mm') ");                   
		 sql.append("and  A.family_id in(select family_id from baseinfo_people w where w.id_card = ?  and w.family_id is not null ) ");
		 List type = new ArrayList();
		 List arg= new ArrayList();
		 type.add(Types.VARCHAR);
		 arg.add(idcard);
		 int[] types1 = new int[type.size()];
		 for (int i = 0; i < type.size(); i++) {
			 types1[i] = (Integer) (type.get(i));
		 }
		 Object[] args1 = arg.toArray(new Object[arg.size()]);
		 DataSet ds = executeDataset(sql.toString(), types1, args1, true);
		 if(ds.getCount() > 0 ){
			 samCheckLog.setResult(false);
			 
			 StringBuffer context = new StringBuffer();
			 for (int i = 0; i < ds.getCount(); i++) {
				Record r = ds.getRecord(i);
				context.append("此人正在【");
				context.append( (String)r.get("DOMICILE_NAME") );
				context.append("】享受【");
				context.append(returnChinese((String)r.get("ASSISTANCE_TYPE")));
				context.append("】户主为【");
				context.append((String)r.get("FAMILY_NAME"));
				context.append(",");
				context.append((String)r.get("FAMILY_CARD_NO"));
				context.append("】");
			}
			 samCheckLog.setContext(context.toString()); 
		 }else{
			samCheckLog.setResult(true);
		 }
		return samCheckLog;
	}
	/**
	 * 将业务代码转换成业务类别名称
	 * @param applyType
	 * @return
	 */
	public String toConvertApplyType(String applyType) {
		if(applyType.equals(SamApplyType.SAM_CITY_NEW_APPLY)){
			return SamApplyType.SAM_CITY_NEW_APPLY_CN;
		}else if(applyType.equals(SamApplyType.SAM_CITY_CHANGE)){
			return SamApplyType.SAM_CITY_CHANGE_CN;
		}else if(applyType.equals(SamApplyType.SAM_CITY_HIS)){
			return SamApplyType.SAM_CITY_HIS_CN;
		}
		
		else if(applyType.equals(SamApplyType.SAM_COUNTRY_NEW_APPLY)){
			return SamApplyType.SAM_COUNTRY_NEW_APPLY_CN;
		}else if(applyType.equals(SamApplyType.SAM_COUNTRY_CHANGE)){
			return SamApplyType.SAM_COUNTRY_CHANGE_CN;
		}else if(applyType.equals(SamApplyType.SAM_COUNTRY_HIS)){
			return SamApplyType.SAM_COUNTRY_HIS_CN;
		}
		
		else if(applyType.equals(SamApplyType.SAM_FIVE_NEW_APPLY)){
			return SamApplyType.SAM_FIVE_NEW_APPLY_CN;
		}else if(applyType.equals(SamApplyType.SAM_FIVE_CHANGE)){
			return SamApplyType.SAM_FIVE_CHANGE_CN;
		}else if(applyType.equals(SamApplyType.SAM_FIVE_HIS)){
			return SamApplyType.SAM_FIVE_HIS_CN;
		}else{
			return "未知的业务";
		}
	}
	/**
	 * 通过传入的代码返回相应的业务类型
	 * @param assistanceType
	 * @return
	 */
	private String returnChinese(String assistanceType) {
		if("01".equals(assistanceType)){
			assistanceType="城市低保";
		}else if("02".equals(assistanceType)){
			assistanceType="农村低保";
		}else if("03".equals(assistanceType)){
			assistanceType="五保";
		}else{
			assistanceType="未知的救助类型";
		}
		return assistanceType;
	}
	
}
